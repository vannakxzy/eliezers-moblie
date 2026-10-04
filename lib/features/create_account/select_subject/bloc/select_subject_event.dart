part of 'select_subject_bloc.dart';

abstract class SelectSubjectEvent extends BaseEvent {}

@freezed
class ClickSkipEvent extends SelectSubjectEvent with _$ClickSkipEvent {
  factory ClickSkipEvent() = _ClickSkipEvent;
}

@freezed
class ClickConfirmEvent extends SelectSubjectEvent with _$ClickConfirmEvent {
  factory ClickConfirmEvent() = _ClickConfirmEvent;
}

@freezed
class ClickSelectSubjectEvent extends SelectSubjectEvent
    with _$ClickSelectSubjectEvent {
  factory ClickSelectSubjectEvent(int id) = _ClickSelectSubjectEvent;
}

@freezed
class GetSubjectEvent extends SelectSubjectEvent with _$GetSubjectEvent {
  factory GetSubjectEvent() = _GetSubjectEvent;
}
