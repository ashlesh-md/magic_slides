import 'package:magic_slides/core/exceptions/auth_failed_exception.dart';
import 'package:magic_slides/core/exceptions/network_exception.dart';
import 'package:magic_slides/feature/authentication/domain/repository/authentication_repository.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/event/authentication_event.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/side_effect/authentication_side_effect.dart';
import 'package:statemachine/statemachine.dart';

class AuthenticationAsyncSideEffectHandler
    extends
        AsyncSideEffectHandler<
          AuthenticationEvent,
          AuthenticationAsyncSideEffect
        > {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationAsyncSideEffectHandler({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;
  @override
  Future<void> handleSideEffect(
    AuthenticationAsyncSideEffect sideEffect,
    DispatchEvent<AuthenticationEvent> dispatchEvent,
  ) async {
    switch (sideEffect) {
      case SignIn _:
        {
          try {
            final status = await _authenticationRepository.signIn(
              email: sideEffect.email,
              password: sideEffect.password,
            );
            if (status) {
              dispatchEvent(SingInSuccess());
            } else {
              dispatchEvent(SingInFailed());
            }
          } on NetworkException catch (error) {
            dispatchEvent(SingInFailed(message: error.message));
          } on AuthFailedException catch (error) {
            dispatchEvent(SingInFailed(message: error.message));
          }
        }
      case SignUp _:
        {
          if (sideEffect.password != sideEffect.confirmedPassword) {
            dispatchEvent(SingUpFailed(message: 'Passwords are not matching'));
            return;
          }
          try {
            final status = await _authenticationRepository.signUp(
              email: sideEffect.email,
              password: sideEffect.password,
            );
            if (status) {
              dispatchEvent(SingUpSuccess());
            } else {
              dispatchEvent(SingUpFailed());
            }
          } on NetworkException catch (error) {
            dispatchEvent(SingInFailed(message: error.message));
          } on AuthFailedException catch (error) {
            dispatchEvent(SingInFailed(message: error.message));
          }
        }
    }
  }

  @override
  void dispose() {}
}
