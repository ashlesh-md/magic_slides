import 'package:magic_slides/feature/home/view/statemachine/home_state.dart';
import 'package:magic_slides/feature/home/view/statemachine/event/home_event.dart';
import 'package:statemachine/statemachine.dart';

class HomeAnalyticsHandler extends AnalyticsEventHandler<HomeEvent, HomeState> {
  @override
  Map<String, dynamic>? getEventParams(HomeEvent event, HomeState state) {
    return null;
  }

  @override
  void sendEvent(HomeEvent event, HomeState state) {}
}
