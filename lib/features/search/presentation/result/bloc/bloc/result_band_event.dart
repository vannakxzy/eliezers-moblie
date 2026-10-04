part of 'result_band_bloc.dart';

class ResultbandEvent extends BaseEvent {}

@freezed
class InitPage extends ResultbandEvent with _$InitPage {
  factory InitPage(String text) = _InitPage;
}

@freezed
class RefreshPage extends ResultbandEvent with _$RefreshPage {
  factory RefreshPage(String text) = _RefreshPage;
}

@freezed
class Clickband extends ResultbandEvent with _$Clickband {
  factory Clickband(BandEntity band) = _Clickband;
}

@freezed
class ClickJoin extends ResultbandEvent with _$ClickJoin {
  factory ClickJoin(int index) = _ClickJoin;
}

@freezed
class ClickLeave extends ResultbandEvent with _$ClickLeave {
  factory ClickLeave(int index) = _ClickLeave;
}

@freezed
class ClickRequest extends ResultbandEvent with _$ClickRequest {
  factory ClickRequest(int index) = _ClickRequest;
}

@freezed
class ClickCancelRequest extends ResultbandEvent with _$ClickCancelRequest {
  factory ClickCancelRequest(int index) = _ClickCancelRequest;
}

@freezed
class RemoveIndex extends ResultbandEvent with _$RemoveIndex {
  factory RemoveIndex(int index) = _RemoveIndex;
}

@freezed
class RemoveAll extends ResultbandEvent with _$RemoveAll {
  factory RemoveAll() = _RemoveAll;
}
