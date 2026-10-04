part of 'band_pendding_bloc.dart';

class bandPenddingEvent extends BaseEvent {}

@freezed
class GetbandRequest extends bandPenddingEvent with _$GetbandRequest {
  factory GetbandRequest() = _Getband;
}

@freezed
class InitPageEvent extends bandPenddingEvent with _$InitPageEvent {
  factory InitPageEvent() = _InitPage;
}

@freezed
class RefreshPage extends bandPenddingEvent with _$RefreshPage {
  factory RefreshPage() = _RefreshPage;
}

@freezed
class Clickband extends bandPenddingEvent with _$Clickband {
  factory Clickband(int index) = _Clickband;
}

@freezed
class ClickCancel extends bandPenddingEvent with _$ClickCancel {
  factory ClickCancel(int index) = _ClickApproveUserInband;
}
