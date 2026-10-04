part of 'global_notify_bloc.dart';

@freezed
class GlobalNotifyState<T extends BaseState> extends BaseState
    with _$GlobalNotifyState {
  const factory GlobalNotifyState({
    @Default({}) Map<Type, T> states,
  }) = _GlobalNotifyState;
}

extension PickState on GlobalNotifyState {
  T? pick<T extends BaseState>() {
    return states[T] as T?;
  }
}
