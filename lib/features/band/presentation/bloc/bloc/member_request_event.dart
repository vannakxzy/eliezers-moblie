part of 'member_request_bloc.dart';

class MemberRequestEvent extends BaseEvent {}

@freezed
class InitPage extends MemberRequestEvent with _$InitPage {
  factory InitPage() = _InitPage;
}

@freezed
class Clickband extends MemberRequestEvent with _$Clickband {
  factory Clickband(BandEntity band) = _Clickband;
}

@freezed
class ClickProfile extends MemberRequestEvent with _$ClickProfile {
  factory ClickProfile(int userId) = _ClickProfile;
}

@freezed
class RefreshPage extends MemberRequestEvent with _$RefreshPage {
  factory RefreshPage() = _RefreshPage;
}

@freezed
class ClickApprove extends MemberRequestEvent with _$ClickApprove {
  factory ClickApprove(int index) = _ClickApprove;
}

@freezed
class ClickDetele extends MemberRequestEvent with _$ClickDetele {
  factory ClickDetele(int index) = _ClickDetele;
}
