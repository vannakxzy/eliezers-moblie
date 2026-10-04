part of 'global_notify_bloc.dart';

abstract class GlobalNotifyEvent extends BaseEvent {
  const GlobalNotifyEvent();
}

@freezed
class GlobalNotifyPageInitiated extends GlobalNotifyEvent
    with _$GlobalNotifyPageInitiated {
  const factory GlobalNotifyPageInitiated() = _GlobalNotifyPageInitiated;
}

@freezed
class NotifyState<T extends BaseState> extends GlobalNotifyEvent
    with _$NotifyState {
  const factory NotifyState(Type type, T newState) = _NotifyState;
}

@freezed
class DisposeState<T extends BaseState> extends GlobalNotifyEvent
    with _$DisposeState {
  const factory DisposeState(Type type) = _DisposeState;
}
