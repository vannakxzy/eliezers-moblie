part of 'select_avtar_bloc.dart';

class SelectAvatarEvent extends BaseEvent {}

@freezed
class GetAvatar extends SelectAvatarEvent with _$GetAvatar {
  factory GetAvatar() = _GetAvatar;
}

@freezed
class ClickSkipEvent extends SelectAvatarEvent with _$ClickSkipEvent {
  factory ClickSkipEvent() = _ClickSkipEvent;
}

@freezed
class ClickAvatar extends SelectAvatarEvent with _$ClickAvatar {
  factory ClickAvatar(int index) = _ClickAvatar;
}

@freezed
class ClickConfirmEvent extends SelectAvatarEvent with _$ClickConfirmEvent {
  factory ClickConfirmEvent() = _ClickConfirmEvent;
}
