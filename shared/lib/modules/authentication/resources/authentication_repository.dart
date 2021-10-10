import 'package:api_sdk/main.dart';

class AuthenticationRepository {

  Future<dynamic> loginWithEmailAndPassword(
      String email, String password,String devicetoken) async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay
    final response = await ApiSdk.loginWithEmailAndPassword(
        {'username': email, 'password': password,'devicetoken':devicetoken});

    return response;
  }

  Future<dynamic> getUserData(int id) async {
    final response = await ApiSdk.getUserData(id);

    return response;
  }
}
