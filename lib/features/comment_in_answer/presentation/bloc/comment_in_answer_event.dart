part of 'comment_in_answer_bloc.dart';

abstract class CommentInAnswerEvent extends BaseEvent {}

@freezed
class GetCommentEvent extends CommentInAnswerEvent with _$GetCommentEvent {
  factory GetCommentEvent(int answerId) = _GetCommentEvent;
}

@freezed
class RefresPage extends CommentInAnswerEvent with _$RefresPage {
  factory RefresPage(int answerId) = _RefresPage;
}

@freezed
class ClickCreateEventCommentEvent extends CommentInAnswerEvent
    with _$ClickCreateEventCommentEvent {
  factory ClickCreateEventCommentEvent(int answerId, int bandId) =
      _ClickCreateEventCommentEvent;
}

@freezed
class ClickCancelEditEvent extends CommentInAnswerEvent
    with _$ClickCancelEditEvent {
  factory ClickCancelEditEvent() = _ClickCancelEditEvent;
}

@freezed
class ClickUpdateEvent extends CommentInAnswerEvent with _$ClickUpdateEvent {
  factory ClickUpdateEvent() = _ClickUpdateEvent;
}

@freezed
class ClickEditEvent extends CommentInAnswerEvent with _$ClickEditEvent {
  factory ClickEditEvent(int index) = _ClickEditEvent;
}

@freezed
class ClickDeleteEvent extends CommentInAnswerEvent with _$ClickDeleteEvent {
  factory ClickDeleteEvent(int index) = _ClickDeleteEvent;
}

@freezed
class DesChangedEvent extends CommentInAnswerEvent with _$DesChangedEvent {
  factory DesChangedEvent(String text) = _DesChangedEvent;
}

@freezed
class ClickLike extends CommentInAnswerEvent with _$ClickLike {
  factory ClickLike(int index) = _ClickLike;
}
