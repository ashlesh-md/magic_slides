import 'package:flutter/material.dart';
import 'package:magic_slides/core/theme/text_styles.dart';
import 'package:magic_slides/feature/authentication/authentication_injection.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/analytics/authentication_analytics_handler.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/side_effect/authentication_async_side_effect_handler.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/event/authentication_event.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/event/authentication_event_handler.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/side_effect/authentication_side_effect.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/authentication_state.dart';
import 'package:magic_slides/utils/app_utils.dart';
import 'package:magic_slides/utils/widgets/app_text_field.dart';
import 'package:statemachine/statemachine.dart';

class AuthenticationView
    extends
        StateMachineWidget<
          AuthenticationEvent,
          AuthenticationState,
          AuthenticationAsyncSideEffect,
          AuthenticationUISideEffect
        > {
  const AuthenticationView({super.key});

  @override
  AppBar? getAppBar(
    AuthenticationState state,
    DispatchEvent<AuthenticationEvent> dispatchEvent,
  ) {
    return AppBar(title: Text(state.showSignInView ? 'Sign In' : 'Sign Up'));
  }

  @override
  Widget buildLayout(
    AuthenticationState state,
    DispatchEvent<AuthenticationEvent> dispatchEvent,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 48),
            Text('Magic Slides', style: CustomTextStyles.m3DisplaySmall),
            const SizedBox(height: 48),

            state.showSignInView
                ? _buildSignInView(state, dispatchEvent)
                : _buildSignUpView(state, dispatchEvent),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInView(
    AuthenticationState state,
    DispatchEvent<AuthenticationEvent> dispatchEvent,
  ) {
    return Form(
      key: state.signInFormKey,
      child: Column(
        spacing: 16,
        children: [
          AppTextField(
            controller: state.emailController,
            keyboardType: TextInputType.emailAddress,
            hint: 'joe@gmail.com',
          ),
          AppTextField(
            controller: state.passwordController,
            hint: 'Password',
            obscureText: true,
          ),
          _authButton("Sign In", () {
            final status = state.signInFormKey.currentState?.validate();
            if (status ?? false) {
              dispatchEvent(SignInClicked());
            }
          }),
          _authToggle(
            leading: "Don't have an account? ",
            action: "Sign Up",
            onTap: () {
              dispatchEvent(SwitchToSignUpClicked());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpView(
    AuthenticationState state,
    DispatchEvent<AuthenticationEvent> dispatchEvent,
  ) {
    return Form(
      key: state.signUpFormKey,
      child: Column(
        spacing: 16,
        children: [
          AppTextField(
            controller: state.emailController,
            keyboardType: TextInputType.emailAddress,
            hint: 'joe@gmail.com',
          ),
          AppTextField(
            controller: state.passwordController,
            obscureText: true,
            hint: 'Password',
          ),
          AppTextField(
            controller: state.confirmPasswordController,
            obscureText: true,
            hint: 'Confirm Password',
          ),

          _authButton("Sign Up", () {
            final status = state.signUpFormKey.currentState?.validate();
            if (status ?? false) {
              dispatchEvent(SignUpClicked());
            }
          }),

          _authToggle(
            leading: "Already have an account? ",
            action: "Sign In",
            onTap: () => dispatchEvent(SwitchToSignInClicked()),
          ),
        ],
      ),
    );
  }

  Widget _authButton(String text, VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Widget _authToggle({
    required String leading,
    required String action,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(leading, style: CustomTextStyles.m3BodyMedium),
          Text(
            action,
            style: CustomTextStyles.m3BodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void handleUISideEffect(
    BuildContext context,
    AuthenticationUISideEffect sideEffect,
    DispatchEvent<AuthenticationEvent> dispatchEvent,
  ) {
    switch (sideEffect) {
      case ShowSnackbar _:
        {
          ScaffoldMessenger.of(context).showSnackBar(
            AppUtils.buildAppSnackBar(context, sideEffect.message),
          );
        }
    }
  }

  @override
  StateMachine<
    AuthenticationEvent,
    AuthenticationState,
    AuthenticationAsyncSideEffect,
    AuthenticationUISideEffect
  >
  injectStateMachine() {
    return StateMachineImpl(
      AuthenticationState(),
      AuthenticationEventHandler(),
      AuthenticationAsyncSideEffectHandler(
        authenticationRepository: authenticationModule(),
      ),
      AuthenticationAnalyticsHandler(),
    );
  }
}
