import 'package:magic_slides/feature/authentication/view/statemachine/authentication_state.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/event/authentication_event.dart';
import 'package:statemachine/statemachine.dart';

class AuthenticationAnalyticsHandler
    extends AnalyticsEventHandler<AuthenticationEvent, AuthenticationState> {
  @override
  Map<String, dynamic>? getEventParams(
    AuthenticationEvent event,
    AuthenticationState state,
  ) {
    return null;
  }

  @override
  void sendEvent(AuthenticationEvent event, AuthenticationState state) {}
}
