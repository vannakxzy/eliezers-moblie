part of 'active_session_bloc.dart';

@freezed
class ActiveSessionState extends BaseState with _$ActiveSessionState {
  const factory ActiveSessionState.initial({
    @Default([]) List<ActiveSessionEntity> activeSession,
    ActiveSessionEntity? yourDevice,
    @Default(true) bool isLoading,
  }) = _Initial;
}
