part of 'appearance_bloc.dart';

class AppearanceEvent extends BaseEvent {}

@freezed
class ClickThemeEvent extends AppearanceEvent with _$ClickThemeEvent {
  factory ClickThemeEvent() = _ClickThemeEvent;
}

@freezed
class InitPage extends AppearanceEvent with _$InitPage {
  factory InitPage() = _InitPage;
}
