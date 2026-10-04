part of 'active_session_bloc.dart';

class ActiveSessionEvent extends BaseEvent {}

@freezed
class GetActiveSession extends ActiveSessionEvent with _$GetActiveSession {
  factory GetActiveSession() = _GetActiveSession;
}

@freezed
class DeleteOneActiveSession extends ActiveSessionEvent
    with _$DeleteOneActiveSession {
  factory DeleteOneActiveSession(int index) = _DeleteOneActiveSession;
}

@freezed
class DeleteOtherActiveSession extends ActiveSessionEvent
    with _$DeleteOtherActiveSession {
  factory DeleteOtherActiveSession() = _DeleteOtherActiveSession;
}
