part of 'comment_in_discussion_bloc.dart';

abstract class CommentInDiscussionEvent extends BaseEvent {}

@freezed
class GetCommentEvent extends CommentInDiscussionEvent with _$GetCommentEvent {
  factory GetCommentEvent(int discussionId) = _GetCommentEvent;
}

@freezed
class RefresPage extends CommentInDiscussionEvent with _$RefresPage {
  factory RefresPage(int discussionId) = _RefresPage;
}

@freezed
class ClickCreateEventCommentEvent extends CommentInDiscussionEvent
    with _$ClickCreateEventCommentEvent {
  factory ClickCreateEventCommentEvent(int discussionId, int bandId) =
      _ClickCreateEventCommentEvent;
}

@freezed
class ClickCancelEditEvent extends CommentInDiscussionEvent
    with _$ClickCancelEditEvent {
  factory ClickCancelEditEvent() = _ClickCancelEditEvent;
}

@freezed
class ClickUpdateEvent extends CommentInDiscussionEvent
    with _$ClickUpdateEvent {
  factory ClickUpdateEvent() = _ClickUpdateEvent;
}

@freezed
class ClickEditEvent extends CommentInDiscussionEvent with _$ClickEditEvent {
  factory ClickEditEvent(int index) = _ClickEditEvent;
}

@freezed
class ClickDeleteEvent extends CommentInDiscussionEvent
    with _$ClickDeleteEvent {
  factory ClickDeleteEvent(int index) = _ClickDeleteEvent;
}

@freezed
class DesChangedEvent extends CommentInDiscussionEvent with _$DesChangedEvent {
  factory DesChangedEvent(String text) = _DesChangedEvent;
}

@freezed
class ClickLike extends CommentInDiscussionEvent with _$ClickLike {
  factory ClickLike(int index) = _ClickLike;
}
