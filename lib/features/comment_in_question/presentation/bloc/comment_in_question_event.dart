part of 'comment_in_question_bloc.dart';

// @freezed
abstract class CommentInQuestionEvent extends BaseEvent {}

@freezed
class GetCommentEvent extends CommentInQuestionEvent with _$GetCommentEvent {
  factory GetCommentEvent(int questionId) = _GetCommentEvent;
}

@freezed
class ClickCreateEventcommentEvent extends CommentInQuestionEvent
    with _$ClickCreateEventcommentEvent {
  factory ClickCreateEventcommentEvent(int questionId, int bandId) =
      _ClickCreateEventcommentEvent;
}

@freezed
class DesChangedEvent extends CommentInQuestionEvent with _$DesChangedEvent {
  factory DesChangedEvent(String value) = _DesChangedEvent;
}

@freezed
class ClickDeleteEvent extends CommentInQuestionEvent with _$ClickDeleteEvent {
  factory ClickDeleteEvent(int index) = _ClickDeleteEvent;
}

@freezed
class ClickEditEvent extends CommentInQuestionEvent with _$ClickEditEvent {
  factory ClickEditEvent(int index) = _ClickEditEvent;
}

@freezed
class ClickUpdateEvent extends CommentInQuestionEvent with _$ClickUpdateEvent {
  factory ClickUpdateEvent() = _ClickUpdateEvent;
}

@freezed
class ClickCancelEditEvent extends CommentInQuestionEvent
    with _$ClickCancelEditEvent {
  factory ClickCancelEditEvent() = _ClickCancelEditEvent;
}

@freezed
class RefreshPage extends CommentInQuestionEvent with _$RefreshPage {
  factory RefreshPage(int questionId) = _RefreshPage;
}

@freezed
class ClickLike extends CommentInQuestionEvent with _$ClickLike {
  factory ClickLike(int index) = _ClickLike;
}
