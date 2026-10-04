part of 'discussion_detail_bloc.dart';

class DiscussionDetailEvent extends BaseEvent {}

@freezed
class InitPage extends DiscussionDetailEvent with _$InitPage {
  factory InitPage(QuestionEntity discussion, int discussionId) = _InitPage;
}

@freezed
class ListionScroll extends DiscussionDetailEvent with _$ListionScroll {
  factory ListionScroll(double value) = _ListionScroll;
}

@freezed
class ClcikPostDiscussion extends DiscussionDetailEvent
    with _$ClcikPostDiscussion {
  factory ClcikPostDiscussion(int discussionId, int bandId) =
      _ClcikPostDiscussion;
}

@freezed
class ClickDeleteAnswer extends DiscussionDetailEvent with _$ClickDeleteAnswer {
  factory ClickDeleteAnswer(int index) = _ClickDeleteAnswer;
}

@freezed
class ClickGetComment extends DiscussionDetailEvent with _$ClickGetComment {
  factory ClickGetComment(int index) = _ClickGetComment;
}

@freezed
class RefresPageEvent extends DiscussionDetailEvent with _$RefresPageEvent {
  factory RefresPageEvent() = _RefresPageEvent;
}

@freezed
class ScrollDirectionUpdate extends DiscussionDetailEvent
    with _$ScrollDirectionUpdate {
  factory ScrollDirectionUpdate(bool value) = _ScrollDirectionUpdate;
}

@freezed
class ClickDownloadImage extends DiscussionDetailEvent
    with _$ClickDownloadImage {
  factory ClickDownloadImage() = _ClickDownloadImage;
}

@freezed
class MessageChangedEvent extends DiscussionDetailEvent
    with _$MessageChangedEvent {
  factory MessageChangedEvent(String value) = _MessageChangedEvent;
}

@freezed
class ClickClearImageEvent extends DiscussionDetailEvent
    with _$ClickClearImageEvent {
  factory ClickClearImageEvent() = _ClickClearImageEvent;
}

@freezed
class ClickPickImageEvent extends DiscussionDetailEvent
    with _$ClickPickImageEvent {
  factory ClickPickImageEvent(File file) = _ClickPickImageEvent;
}

@freezed
class ClcikCreateDiscussionDetailEvent extends DiscussionDetailEvent
    with _$ClcikCreateDiscussionDetailEvent {
  factory ClcikCreateDiscussionDetailEvent(int questionId) =
      _ClcikCreateDiscussionDetailEvent;
}

@freezed
class ClickEditAnswer extends DiscussionDetailEvent with _$ClickEditAnswer {
  factory ClickEditAnswer(int index) = _ClcikEditEvent;
}

@freezed
class ClickEditDiscussionEvent extends DiscussionDetailEvent
    with _$ClickEditDiscussionEvent {
  factory ClickEditDiscussionEvent(int index) = _ClickEditDiscussionEvent;
}

@freezed
class ClickCancelEdit extends DiscussionDetailEvent with _$ClickCancelEdit {
  factory ClickCancelEdit() = _ClickCancelEdit;
}

@freezed
class ClickUpdateQuestion extends DiscussionDetailEvent
    with _$ClickUpdateQuestion {
  factory ClickUpdateQuestion(QuestionEntity discussion) = _ClickUpdateQuestion;
}

@freezed
class ClickUpdateAnswer extends DiscussionDetailEvent with _$ClickUpdateAnswer {
  factory ClickUpdateAnswer() = _ClickUpdateAnswer;
}

@freezed
class ClickShare extends DiscussionDetailEvent with _$ClickShare {
  factory ClickShare(QuestionEntity discussion) = _ClickShare;
}

@freezed
class ClickBlockUserEvent extends DiscussionDetailEvent
    with _$ClickBlockUserEvent {
  factory ClickBlockUserEvent(int userId) = _ClickBlockUserEvent;
}

@freezed
class ClickEditDiscussionDetail extends DiscussionDetailEvent
    with _$ClickEditDiscussionDetail {
  factory ClickEditDiscussionDetail(int index) = _ClickEditDiscussionDetail;
}

@freezed
class ClickLikeAnswerEvent extends DiscussionDetailEvent
    with _$ClickLikeAnswerEvent {
  factory ClickLikeAnswerEvent(int index) = _ClickLikeAnswerEvent;
}

@freezed
class ClickLikeDiscussion extends DiscussionDetailEvent
    with _$ClickLikeDiscussion {
  factory ClickLikeDiscussion(int index) = _ClickLikeDiscussion;
}

@freezed
class ClickProfileEvent extends DiscussionDetailEvent with _$ClickProfileEvent {
  factory ClickProfileEvent(int userId) = _ClickProfileEvent;
}

@freezed
class ClickQuestionProfileEvent extends DiscussionDetailEvent
    with _$ClickQuestionProfileEvent {
  factory ClickQuestionProfileEvent(int userId) = _ClickQuestionProfileEvent;
}

@freezed
class ClickReportEvent extends DiscussionDetailEvent with _$ClickReportEvent {
  factory ClickReportEvent() = _ClickReportEvent;
}

@freezed
class ClickDeleteDiscusstionEvent extends DiscussionDetailEvent
    with _$ClickDeleteDiscusstionEvent {
  factory ClickDeleteDiscusstionEvent(int questionId) =
      _ClickDeleteDiscusstionEvent;
}

@freezed
class PressDeleteDiscussionDetailEvent extends DiscussionDetailEvent
    with _$PressDeleteDiscussionDetailEvent {
  factory PressDeleteDiscussionDetailEvent(int index) =
      _PressDeleteDiscussionDetailEvent;
}

@freezed
class ClickDownloadPhoroEvent extends DiscussionDetailEvent
    with _$ClickDownloadPhoroEvent {
  factory ClickDownloadPhoroEvent(String urlImage) = _ClickDownloadPhoroEvent;
}

@freezed
class GetDiscussionByIdEvent extends DiscussionDetailEvent
    with _$GetDiscussionByIdEvent {
  factory GetDiscussionByIdEvent(int id) = _GetDiscussionByIdEvent;
}

@freezed
class GetAnswerInDiscussionEvent extends DiscussionDetailEvent
    with _$GetAnswerInDiscussionEvent {
  factory GetAnswerInDiscussionEvent(int id) = _GetAnswerInDiscussionEvent;
}

@freezed
class ClickLlikeComment extends DiscussionDetailEvent with _$ClickLlikeComment {
  factory ClickLlikeComment(int answerIndex, int commentIndex) =
      _ClickLlikeComment;
}

@freezed
class ClickDeleteComment extends DiscussionDetailEvent
    with _$ClickDeleteComment {
  factory ClickDeleteComment(int answerIndex, int commentIndex) =
      _ClickDeleteComment;
}

@freezed
class CommentMesChanged extends DiscussionDetailEvent with _$CommentMesChanged {
  factory CommentMesChanged(String value) = _CommentMesChanged;
}

@freezed
class ClickReplyComment extends DiscussionDetailEvent with _$ClickReplyComment {
  factory ClickReplyComment(int answerIndex, int commentIndex) = _ClickComment;
}

@freezed
class ClickAnswer extends DiscussionDetailEvent with _$ClickAnswer {
  factory ClickAnswer() = _ClickAnswer;
}

@freezed
class CreateComment extends DiscussionDetailEvent with _$CreateComment {
  factory CreateComment() = _CreateComment;
}

@freezed
class ClickEditComment extends DiscussionDetailEvent with _$ClickEditComment {
  factory ClickEditComment(int answerIndex, int commentIndex) =
      _ClickEditComment;
}

@freezed
class ClickUpdateComment extends DiscussionDetailEvent
    with _$ClickUpdateComment {
  factory ClickUpdateComment() = _ClickUpdateComment;
}

@freezed
class ClickCancelReply extends DiscussionDetailEvent with _$ClickCancelReply {
  factory ClickCancelReply() = _ClickCancelReply;
}
