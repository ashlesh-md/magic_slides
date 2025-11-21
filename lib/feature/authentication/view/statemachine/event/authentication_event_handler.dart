import 'package:magic_slides/feature/authentication/view/statemachine/event/authentication_event.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/side_effect/authentication_side_effect.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/authentication_state.dart';
import 'package:statemachine/statemachine.dart';

class AuthenticationEventHandler
    extends
        EventHandler<
          AuthenticationEvent,
          AuthenticationState,
          AuthenticationAsyncSideEffect,
          AuthenticationUISideEffect
        > {
  @override
  Next<
    AuthenticationState?,
    AuthenticationAsyncSideEffect?,
    AuthenticationUISideEffect?
  >
  handleEvent(AuthenticationEvent event, AuthenticationState state) {
    switch (event) {
      case SwitchToSignInClicked _:
        {
          return Next(state: state..updateShowInViewStatus(true));
        }
      case SwitchToSignUpClicked _:
        {
          return Next(state: state..updateShowInViewStatus(false));
        }

      case SignInClicked _:
        {
          return Next(
            asyncSideEffect: SignIn(
              email: state.emailController.text.trim(),
              password: state.passwordController.text.trim(),
            ),
          );
        }
      case SignUpClicked _:
        {
          final password = state.passwordController.text.trim();
          final confirmedPassword = state.confirmPasswordController.text.trim();
          return Next(
            asyncSideEffect: SignUp(
              email: state.emailController.text.trim(),
              password: password,
              confirmedPassword: confirmedPassword,
            ),
          );
        }
      case SingInSuccess _:
        {
          return Next(uiSideEffect: ShowSnackbar('Successfully signed in'));
        }

      case SingInFailed _:
        {
          return Next(
            uiSideEffect: ShowSnackbar(
              event.message ?? 'Sign in failed. Please try again',
            ),
          );
        }

      case SingUpSuccess _:
        {
          return Next(
            uiSideEffect: ShowSnackbar('Account created successfully'),
          );
        }

      case SingUpFailed _:
        {
          return Next(
            uiSideEffect: ShowSnackbar(
              (event.message ?? 'Sign up failed. Please try again'),
            ),
          );
        }
    }
  }
}
