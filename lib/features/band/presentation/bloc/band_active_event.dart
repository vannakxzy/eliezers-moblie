part of 'band_active_bloc.dart';

class bandActiveEvent extends BaseEvent {}

@freezed
class InitPageEvent extends bandActiveEvent with _$InitPageEvent {
  factory InitPageEvent() = _InitPageEvent;
}

@freezed
class RefreshPageEvent extends bandActiveEvent with _$RefreshPageEvent {
  factory RefreshPageEvent() = _RefreshPageEvent;
}

@freezed
class ClickbandEvent extends bandActiveEvent with _$ClickbandEvent {
  factory ClickbandEvent(int index) = _ClickbandEvent;
}

@freezed
class ClickLeave extends bandActiveEvent with _$ClickLeave {
  factory ClickLeave(int index) = _ClickLeave;
}
