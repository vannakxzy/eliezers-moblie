part of 'result_discussion_bloc.dart';

class ResultDiscussionEvent extends BaseEvent {}

@freezed
class SearchQuestionEvent extends ResultDiscussionEvent
    with _$SearchQuestionEvent {
  factory SearchQuestionEvent(String text) = _SearchQuestionEvent;
}

@freezed
class ClickSaveQuestion extends ResultDiscussionEvent with _$ClickSaveQuestion {
  factory ClickSaveQuestion(int index) = _ClickSaveQuestion;
}

@freezed
class OnRefreshPageEvent extends ResultDiscussionEvent
    with _$OnRefreshPageEvent {
  factory OnRefreshPageEvent(String text) = _OnRefreshPageEvent;
}

@freezed
class ClickQuestionEvetn extends ResultDiscussionEvent
    with _$ClickQuestionEvetn {
  factory ClickQuestionEvetn(QuestionEntity question, int id) =
      _ClickQuestionEvetn;
}

@freezed
class DoubleTapEvent extends ResultDiscussionEvent with _$DoubleTapEvent {
  factory DoubleTapEvent(int index) = _DoubleTapEvent;
}

@freezed
class ClickHideEvent extends ResultDiscussionEvent with _$ClickHideEvent {
  factory ClickHideEvent(int index) = _ClickHideEvent;
}

@freezed
class ClickUnHideEvent extends ResultDiscussionEvent with _$ClickUnHideEvent {
  factory ClickUnHideEvent(int index) = _ClickUnHideEvent;
}

@freezed
class ClickLikeEvent extends ResultDiscussionEvent with _$ClickLikeEvent {
  factory ClickLikeEvent(int index) = _ClickLikeEvent;
}

@freezed
class ClickOnUser extends ResultDiscussionEvent with _$ClickOnUser {
  factory ClickOnUser(int id) = _ClickOnUser;
}

@freezed
class ClickShareQuestion extends ResultDiscussionEvent
    with _$ClickShareQuestion {
  factory ClickShareQuestion(QuestionEntity question) = _ClickShareQuestion;
}

@freezed
class RemoveIndex extends ResultDiscussionEvent with _$RemoveIndex {
  factory RemoveIndex(int index) = _RemoveIndex;
}

@freezed
class RemoveAll extends ResultDiscussionEvent with _$RemoveAll {
  factory RemoveAll() = _RemoveAll;
}
