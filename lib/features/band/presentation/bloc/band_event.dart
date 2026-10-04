part of 'band_bloc.dart';

class BandEvent extends BaseEvent {}

@freezed
class InitPage extends BandEvent with _$InitPage {
  factory InitPage(int page) = _InitPage;
}

@freezed
class ClickRefreshPage extends BandEvent with _$ClickRefreshPage {
  factory ClickRefreshPage(int page) = _ClickRefreshPage;
}

@freezed
class Clickband extends BandEvent with _$Clickband {
  factory Clickband(int index) = _Clickband;
}

@freezed
class ClickCreateband extends BandEvent with _$ClickCreateband {
  factory ClickCreateband() = _ClickCreateband;
}

@freezed
class ClickLeave extends BandEvent with _$ClickLeave {
  factory ClickLeave(int index) = _ClickLeave;
}
