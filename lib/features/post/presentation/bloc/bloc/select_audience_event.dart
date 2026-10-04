part of 'select_audience_bloc.dart';

class SelectAudienceEvent extends BaseEvent {}

@freezed
class InitPage extends SelectAudienceEvent with _$InitPage {
  factory InitPage(String value) = _InitPage;
}

@freezed
class ClickAudienceEvent extends SelectAudienceEvent with _$ClickAudienceEvent {
  factory ClickAudienceEvent(String value) = _ClickAudienceEvent;
}

@freezed
class ClickSetDefualt extends SelectAudienceEvent with _$ClickSetDefualt {
  factory ClickSetDefualt() = _ClickSetDefualt;
}

@freezed
class ClickDone extends SelectAudienceEvent with _$ClickDone {
  factory ClickDone() = _ClickDone;
}
