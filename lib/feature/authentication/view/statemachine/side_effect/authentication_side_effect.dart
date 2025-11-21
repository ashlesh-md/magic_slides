// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:statemachine/statemachine.dart';

sealed class AuthenticationAsyncSideEffect extends AsyncSideEffect {}

class SignIn extends AuthenticationAsyncSideEffect {
  String email;
  String password;
  SignIn({required this.email, required this.password});
}

class SignUp extends AuthenticationAsyncSideEffect {
  String email;
  String password;
  String confirmedPassword;
  SignUp({
    required this.email,
    required this.password,
    required this.confirmedPassword,
  });
}

sealed class AuthenticationUISideEffect extends UISideEffect {}

class ShowSnackbar extends AuthenticationUISideEffect {
  final String message;
  ShowSnackbar(this.message);
}
