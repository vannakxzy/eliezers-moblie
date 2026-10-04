part of 'add_band_member_bloc.dart';

class AddbandMemberEvent extends BaseEvent {}

@freezed
class InitPage extends AddbandMemberEvent with _$InitPage {
  factory InitPage() = _InitPage;
}

@freezed
class TextChanged extends AddbandMemberEvent with _$TextChanged {
  factory TextChanged(String value, int bandId) = _TextChanged;
}

@freezed
class ClickUser extends AddbandMemberEvent with _$ClickUser {
  factory ClickUser(int userId) = _ClickUser;
}

@freezed
class ClearTextSearch extends AddbandMemberEvent with _$ClearTextSearch {
  factory ClearTextSearch() = _ClearTextSearch;
}

@freezed
class ClickAddMember extends AddbandMemberEvent with _$ClickAddMember {
  factory ClickAddMember(int bandId) = _ClickAddMember;
}

@freezed
class RefreshPage extends AddbandMemberEvent with _$RefreshPage {
  factory RefreshPage() = _RefreshPage;
}

@freezed
class SelectUser extends AddbandMemberEvent with _$SelectUser {
  factory SelectUser(ProfileEntity user) = _SelectUser;
}

@freezed
class RemoverSelectedIndex extends AddbandMemberEvent
    with _$RemoverSelectedIndex {
  factory RemoverSelectedIndex(int index) = _RemoverSelectedIndex;
}

@freezed
class RemoveAllSelected extends AddbandMemberEvent with _$RemoveAllSelected {
  factory RemoveAllSelected() = _RemoveAllSelected;
}
