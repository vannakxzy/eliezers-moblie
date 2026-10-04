
part of 'welcome_bloc.dart';

@freezed
class WelcomeEvent extends BaseEvent with _$WelcomeEvent {
  const factory WelcomeEvent.started() = _Started;
}