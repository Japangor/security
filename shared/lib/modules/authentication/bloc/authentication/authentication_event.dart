import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class AppLoadedup extends AuthenticationEvent {}

class UserLogOut extends AuthenticationEvent {}

class GetUserData extends AuthenticationEvent {}



class UserLogin extends AuthenticationEvent {
  final String email;
  final String password;
  final String devicetoken;
  UserLogin({@required this.email, this.password,this.devicetoken});

  @override
  List<Object> get props => [email, password,devicetoken];
}
