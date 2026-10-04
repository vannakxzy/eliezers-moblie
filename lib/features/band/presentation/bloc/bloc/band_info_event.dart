part of 'band_info_bloc.dart';

class bandInfoEvent extends BaseEvent {}

@freezed
class InitPage extends bandInfoEvent with _$InitPage {
  factory InitPage(BandEntity band) = _InitPage;
}

@freezed
class ClickAddMember extends bandInfoEvent with _$ClickAddMember {
  factory ClickAddMember(BandEntity band) = _ClickAddMember;
}

@freezed
class ClickMember extends bandInfoEvent with _$ClickMember {
  factory ClickMember(int userId) = _ClickMember;
}

@freezed
class ClcikRemovebandMember extends bandInfoEvent with _$ClcikRemovebandMember {
  factory ClcikRemovebandMember(int index, int bandId) = _ClcikRemovebandMember;
}

@freezed
class RefreshPage extends bandInfoEvent with _$RefreshPage {
  factory RefreshPage(BandEntity band) = _RefreshPage;
}

@freezed
class UpdateNewMemberEvent extends bandInfoEvent with _$UpdateNewMemberEvent {
  factory UpdateNewMemberEvent(List<bandMemberEntity> member) =
      _UpdateNewMemberEvent;
}

@freezed
class ClickEdit extends bandInfoEvent with _$ClickEdit {
  factory ClickEdit() = _ClickEdit;
}
