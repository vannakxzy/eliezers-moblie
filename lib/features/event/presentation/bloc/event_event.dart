part of 'event_bloc.dart';

class EventEvent extends BaseEvent {}

@freezed
class InitPage extends EventEvent with _$InitPage {
  const factory InitPage() = _InitPage;
}

@freezed
class ClickEvent extends EventEvent with _$ClickEvent {
  factory ClickEvent(int index) = _ClickEvent;
}

@freezed
class ClickJoin extends EventEvent with _$ClickJoin {
  factory ClickJoin(int index) = _ClickJoin;
}

@freezed
class Refreshpage extends EventEvent with _$Refreshpage {
  factory Refreshpage(int index) = _Refreshpage;
}
