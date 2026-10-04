part of 'result_question_bloc.dart';

class ResultQuestionEvent extends BaseEvent {}

@freezed
class SearchQuestionEvent extends ResultQuestionEvent
    with _$SearchQuestionEvent {
  factory SearchQuestionEvent(String text) = _SearchQuestionEvent;
}

@freezed
class ClickSaveQuestion extends ResultQuestionEvent with _$ClickSaveQuestion {
  factory ClickSaveQuestion(int index) = _ClickSaveQuestion;
}

@freezed
class OnRefreshPageEvent extends ResultQuestionEvent with _$OnRefreshPageEvent {
  factory OnRefreshPageEvent(String text) = _OnRefreshPageEvent;
}

@freezed
class ClickQuestionEvetn extends ResultQuestionEvent with _$ClickQuestionEvetn {
  factory ClickQuestionEvetn(QuestionEntity question, int id) =
      _ClickQuestionEvetn;
}

@freezed
class DoubleTapEvent extends ResultQuestionEvent with _$DoubleTapEvent {
  factory DoubleTapEvent(int index) = _DoubleTapEvent;
}

@freezed
class ClickHideEvent extends ResultQuestionEvent with _$ClickHideEvent {
  factory ClickHideEvent(int index) = _ClickHideEvent;
}

@freezed
class ClickUnHideEvent extends ResultQuestionEvent with _$ClickUnHideEvent {
  factory ClickUnHideEvent(int index) = _ClickUnHideEvent;
}

@freezed
class ClickLikeEvent extends ResultQuestionEvent with _$ClickLikeEvent {
  factory ClickLikeEvent(int index) = _ClickLikeEvent;
}

@freezed
class ClickOnUser extends ResultQuestionEvent with _$ClickOnUser {
  factory ClickOnUser(int id) = _ClickOnUser;
}

@freezed
class ClickShareQuestion extends ResultQuestionEvent with _$ClickShareQuestion {
  factory ClickShareQuestion(QuestionEntity question) = _ClickShareQuestion;
}

@freezed
class RemoveIndex extends ResultQuestionEvent with _$RemoveIndex {
  factory RemoveIndex(int index) = _RemoveIndex;
}

@freezed
class RemoveAll extends ResultQuestionEvent with _$RemoveAll {
  factory RemoveAll() = _RemoveAll;
}
