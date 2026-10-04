part of 'band_member_bloc.dart';

class bandMemberEvent extends BaseEvent {}

@freezed
class InitPage extends bandMemberEvent with _$InitPage {
  factory InitPage(int bandId) = _InitPage;
}

@freezed
class ClickAddMember extends bandMemberEvent with _$ClickAddMember {
  factory ClickAddMember(BandEntity band) = _ClickAddMember;
}

@freezed
class ClickMember extends bandMemberEvent with _$ClickMember {
  factory ClickMember(int userId) = _ClickMember;
}

@freezed
class ClickRemove extends bandMemberEvent with _$ClickRemove {
  factory ClickRemove(int index, int bandId) = _ClickRemove;
}

@freezed
class TextChanged extends bandMemberEvent with _$TextChanged {
  factory TextChanged(int bandId, String value) = _TextChanged;
}

@freezed
class ClearTextSearch extends bandMemberEvent with _$ClearTextSearch {
  factory ClearTextSearch() = _ClearTextSearch;
}

@freezed
class RefreshPage extends bandMemberEvent with _$RefreshPage {
  factory RefreshPage(int bandId) = _RefreshPage;
}

@freezed
class ClickMorePage extends bandMemberEvent with _$ClickMorePage {
  factory ClickMorePage(int bandId) = _ClickMorePage;
}
