part of 'band_permissions_bloc.dart';

class bandPermissionsEvent extends BaseEvent {}

@freezed
class InitPage extends bandPermissionsEvent with _$InitPage {
  factory InitPage(bandPermissionEntity permission) = _InitPage;
}

@freezed
class CreateDiscussionChange extends bandPermissionsEvent
    with _$CreateDiscussionChange {
  factory CreateDiscussionChange(bool value) = _CreatebandChanged;
}

@freezed
class CreateQuestionChanged extends bandPermissionsEvent
    with _$CreateQuestionChanged {
  factory CreateQuestionChanged(bool value) = _CreateQuestionChanged;
}

@freezed
class AddMemberChanged extends bandPermissionsEvent with _$AddMemberChanged {
  factory AddMemberChanged(bool value) = _AddMemberChanged;
}

@freezed
class SendMessageChanged extends bandPermissionsEvent
    with _$SendMessageChanged {
  factory SendMessageChanged(bool value) = _SendMessageChanged;
}

@freezed
class RecectionChanged extends bandPermissionsEvent with _$RecectionChanged {
  factory RecectionChanged(bool value) = _RecectionChanged;
}

@freezed
class ChnageInfoChanged extends bandPermissionsEvent with _$ChnageInfoChanged {
  factory ChnageInfoChanged(bool value) = _ChnageInfoChanged;
}

@freezed
class ClickSave extends bandPermissionsEvent with _$ClickSave {
  factory ClickSave(int id) = _ClickSave;
}
