import 'dart:convert';
import 'dart:io';

import 'package:api_sdk/api_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shared/main.dart';
import 'package:shared/modules/authentication/models/current_user_data.dart';
import 'package:shared/modules/authentication/models/security.dart';

import 'package:shared/modules/authentication/resources/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_bloc_public.dart';
import 'package:http/http.dart' as http;
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());
  final AuthenticationRepository authenticationService =
      AuthenticationRepository();
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    final SharedPreferences sharedPreferences = await prefs;
    if (event is AppLoadedup) {
      yield* _mapAppSignUpLoadedState(event);
    }


    if (event is UserLogin) {
      yield* _mapUserLoginState(event);
    }
    if (event is UserLogOut) {
      sharedPreferences.setString('VisiteeID', null);
      sharedPreferences.setString('SecurityID', null);
      yield UserLogoutState();
    }
    if (event is GetUserData) {
      int currentUserId = sharedPreferences.getInt('');
      final data = await authenticationService.getUserData(currentUserId ?? 6);
      final currentUserData = CurrentUserData.fromJson(data);
      yield SetUserData(currentUserData: currentUserData);
    }
  }

  Stream<AuthenticationState> _mapAppSignUpLoadedState(
      AppLoadedup event) async* {
    yield AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('SecurityID') != null) {
        yield SecurityAppAutheticated();
      }
      else if (prefs.getString('VisiteeID') != null) {
    yield VisiteAppAutheticated();
    }
      else {
        yield AuthenticationStart();
      }
    } catch (e) {
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }


  Stream<AuthenticationState> _mapUserLoginState(UserLogin event) async* {
    final SharedPreferences sharedPreferences = await prefs;
    yield AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      final data = await authenticationService.loginWithEmailAndPassword(
          event.email, event.password,event.devicetoken);
      var loginurl = '${apiConstants["auth"]}';
      Map<String, String> loginparam = {
        'username': event.email,
        'password': event.password,
        'devicetoken':'event.lat',
      };

      var headers = {
        HttpHeaders.authorizationHeader: 'Token ',
        HttpHeaders.contentTypeHeader: 'application/json',
      };

      String loginquery = Uri(queryParameters: loginparam).query;

      var loginrequestUrl = loginurl + '?' + loginquery; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
      var response = await http.get(loginrequestUrl, headers: headers);
      Map<String, dynamic> loginresponseJson = json.decode(response.body);
      print(loginresponseJson);

      if (loginresponseJson["success"] == "true") {
        if(loginresponseJson["SecurityID"] !=null)
        {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('SecurityID', loginresponseJson["SecurityID"]);
          print(prefs.getString('SecurityID'));
          print("Security Loged in"+loginresponseJson["SecurityID"]);

            yield SecurityAppAutheticated();
        }
        else if(loginresponseJson["VisiteeID"] !=null)
        {
          SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('VisiteeID', loginresponseJson["VisiteeID"]);
            print(prefs.getString('VisiteeID'));
        print("Visitee Loged in"+loginresponseJson["VisiteeID"]);
          yield VisiteAppAutheticated();


        }

      } else {
        yield AuthenticationFailure(message: data["error"]);
      }
    } catch (e) {
      yield AuthenticationFailure(
          message: e.toString() ?? 'An unknown error occurred');
    }
  }
}
