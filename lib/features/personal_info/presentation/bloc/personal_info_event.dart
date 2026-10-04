part of 'personal_info_bloc.dart';

abstract class PersonalInfoEvent extends BaseEvent {}

@freezed
class GetProfileEvent extends PersonalInfoEvent with _$GetProfileEvent {
  factory GetProfileEvent() = _GetProfileEvent;
}

@freezed
class NameChangedEvent extends PersonalInfoEvent with _$NameChangedEvent {
  factory NameChangedEvent(String value) = _NameChangedEvent;
}

@freezed
class UserNameChangedEvent extends PersonalInfoEvent
    with _$UserNameChangedEvent {
  factory UserNameChangedEvent() = _UserNameChangedEvent;
}

@freezed
class BioChangedEvent extends PersonalInfoEvent with _$BioChangedEvent {
  factory BioChangedEvent(String value) = _BioChangedEvent;
}

@freezed
class EmailChangedEvent extends PersonalInfoEvent with _$EmailChangedEvent {
  factory EmailChangedEvent() = _EmailChangedEvent;
}

@freezed
class ClickUpdated extends PersonalInfoEvent with _$ClickUpdated {
  factory ClickUpdated() = _ClickUpdated;
}

@freezed
class ClickCheckEmail extends PersonalInfoEvent with _$ClickCheckEmail {
  factory ClickCheckEmail(String email) = _ClickCheckEmail;
}

@freezed
class ClickCheckUserNameEvent extends PersonalInfoEvent
    with _$ClickCheckUserNameEvent {
  factory ClickCheckUserNameEvent(String userName) = _ClickCheckUserNameEvent;
}

@freezed
class ClickSelectAvatarEvent extends PersonalInfoEvent
    with _$ClickSelectAvatarEvent {
  factory ClickSelectAvatarEvent(String? avatar) = _ClickSelectAvatarEvent;
}

@freezed
class SelectProfileImage extends PersonalInfoEvent with _$SelectProfileImage {
  const factory SelectProfileImage(File imageFile) = _SelectProfileImage;
}

@freezed
class ClickShareUser extends PersonalInfoEvent with _$ClickShareUser {
  factory ClickShareUser() = _ClickShareUser;
}
