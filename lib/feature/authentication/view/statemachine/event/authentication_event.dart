import 'package:statemachine/statemachine.dart';

sealed class AuthenticationEvent extends Event {
  AuthenticationEvent(super.eventName);
}

class SwitchToSignInClicked extends AuthenticationEvent {
  SwitchToSignInClicked() : super("");
}

class SwitchToSignUpClicked extends AuthenticationEvent {
  SwitchToSignUpClicked() : super("");
}

class SignUpClicked extends AuthenticationEvent {
  SignUpClicked() : super("");
}

class SignInClicked extends AuthenticationEvent {
  SignInClicked() : super("");
}

class SingInSuccess extends AuthenticationEvent {
  SingInSuccess() : super("");
}

class SingInFailed extends AuthenticationEvent {
  String? message;
  SingInFailed({this.message}) : super("");
}

class SingUpSuccess extends AuthenticationEvent {
  SingUpSuccess() : super("");
}

class SingUpFailed extends AuthenticationEvent {
  String? message;
  SingUpFailed({this.message}) : super("");
}
