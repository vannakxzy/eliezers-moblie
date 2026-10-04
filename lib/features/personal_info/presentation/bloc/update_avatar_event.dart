part of 'update_avatar_bloc.dart';

class UpdateAvatarEvent extends BaseEvent {}

@freezed
class GetAvatarEvent extends UpdateAvatarEvent with _$GetAvatarEvent {
  factory GetAvatarEvent() = _GetAvatarEvent;
}

@freezed
class ClickAvatarEvent extends UpdateAvatarEvent with _$ClickAvatarEvent {
  factory ClickAvatarEvent(int index) = _ClickAvatarEvent;
}

@freezed
class ClickCancelEvent extends UpdateAvatarEvent with _$ClickCancelEvent {
  factory ClickCancelEvent() = _ClickCancelEvent;
}

@freezed
class ClickConfirmEvent extends UpdateAvatarEvent with _$ClickConfirmEvent {
  factory ClickConfirmEvent() = _ClickConfirmEvent;
}
