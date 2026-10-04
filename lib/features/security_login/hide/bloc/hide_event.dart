part of 'hide_bloc.dart';

class HideEvent extends BaseEvent {}

@freezed
class GetHideEvent extends HideEvent with _$GetHideEvent {
  factory GetHideEvent() = _GetHideEvent;
}

@freezed
class ClickUnHideEvent extends HideEvent with _$ClickUnHideEvent {
  factory ClickUnHideEvent(int index) = _ClickUnHideEvent;
}

@freezed
class RefreshPage extends HideEvent with _$RefreshPage {
  factory RefreshPage() = _RefreshPage;
}
