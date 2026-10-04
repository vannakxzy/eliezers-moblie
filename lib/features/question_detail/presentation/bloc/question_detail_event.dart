part of 'question_detail_bloc.dart';

abstract class QuestionDetailEvent extends BaseEvent {}

@freezed
class InitPage extends QuestionDetailEvent with _$InitPage {
  factory InitPage(QuestionEntity question, int discussionId) = _InitPage;
}

@freezed
class ListionScroll extends QuestionDetailEvent with _$ListionScroll {
  factory ListionScroll(double value) = _ListionScroll;
}

@freezed
class ClcikPostDiscussion extends QuestionDetailEvent
    with _$ClcikPostDiscussion {
  factory ClcikPostDiscussion(int discussionId, int bandId) =
      _ClcikPostDiscussion;
}

@freezed
class ClickDeleteAnswer extends QuestionDetailEvent with _$ClickDeleteAnswer {
  factory ClickDeleteAnswer(int index) = _ClickDeleteAnswer;
}

@freezed
class ClickGetComment extends QuestionDetailEvent with _$ClickGetComment {
  factory ClickGetComment(int index) = _ClickGetComment;
}

@freezed
class RefresPageEvent extends QuestionDetailEvent with _$RefresPageEvent {
  factory RefresPageEvent() = _RefresPageEvent;
}

@freezed
class ScrollDirectionUpdate extends QuestionDetailEvent
    with _$ScrollDirectionUpdate {
  factory ScrollDirectionUpdate(bool value) = _ScrollDirectionUpdate;
}

@freezed
class ClickDownloadImage extends QuestionDetailEvent with _$ClickDownloadImage {
  factory ClickDownloadImage() = _ClickDownloadImage;
}

@freezed
class MessageChangedEvent extends QuestionDetailEvent
    with _$MessageChangedEvent {
  factory MessageChangedEvent(String value) = _MessageChangedEvent;
}

@freezed
class ClickClearImageEvent extends QuestionDetailEvent
    with _$ClickClearImageEvent {
  factory ClickClearImageEvent() = _ClickClearImageEvent;
}

@freezed
class ClickPickImageEvent extends QuestionDetailEvent
    with _$ClickPickImageEvent {
  factory ClickPickImageEvent(File file) = _ClickPickImageEvent;
}

@freezed
class ClcikCreateDiscussionDetailEvent extends QuestionDetailEvent
    with _$ClcikCreateDiscussionDetailEvent {
  factory ClcikCreateDiscussionDetailEvent(int questionId) =
      _ClcikCreateDiscussionDetailEvent;
}

@freezed
class ClickEditAnswer extends QuestionDetailEvent with _$ClickEditAnswer {
  factory ClickEditAnswer(int index) = _ClcikEditEvent;
}

@freezed
class ClickEditDiscussionEvent extends QuestionDetailEvent
    with _$ClickEditDiscussionEvent {
  factory ClickEditDiscussionEvent(int index) = _ClickEditDiscussionEvent;
}

@freezed
class ClickCancelEdit extends QuestionDetailEvent with _$ClickCancelEdit {
  factory ClickCancelEdit() = _ClickCancelEdit;
}

@freezed
class ClickUpdateQuestion extends QuestionDetailEvent
    with _$ClickUpdateQuestion {
  factory ClickUpdateQuestion(QuestionEntity question) = _ClickUpdateQuestion;
}

@freezed
class ClickUpdateAnswer extends QuestionDetailEvent with _$ClickUpdateAnswer {
  factory ClickUpdateAnswer() = _ClickUpdateAnswer;
}

@freezed
class ClickShare extends QuestionDetailEvent with _$ClickShare {
  factory ClickShare(QuestionEntity question) = _ClickShare;
}

@freezed
class ClickBlockUserEvent extends QuestionDetailEvent
    with _$ClickBlockUserEvent {
  factory ClickBlockUserEvent(int userId) = _ClickBlockUserEvent;
}

@freezed
class ClickEditDiscussionDetail extends QuestionDetailEvent
    with _$ClickEditDiscussionDetail {
  factory ClickEditDiscussionDetail(int index) = _ClickEditDiscussionDetail;
}

@freezed
class ClickLikeAnswerEvent extends QuestionDetailEvent
    with _$ClickLikeAnswerEvent {
  factory ClickLikeAnswerEvent(int index) = _ClickLikeAnswerEvent;
}

@freezed
class ClickLikeDiscussion extends QuestionDetailEvent
    with _$ClickLikeDiscussion {
  factory ClickLikeDiscussion(int index) = _ClickLikeDiscussion;
}

@freezed
class ClickProfileEvent extends QuestionDetailEvent with _$ClickProfileEvent {
  factory ClickProfileEvent(int userId) = _ClickProfileEvent;
}

@freezed
class ClickQuestionProfileEvent extends QuestionDetailEvent
    with _$ClickQuestionProfileEvent {
  factory ClickQuestionProfileEvent(int userId) = _ClickQuestionProfileEvent;
}

@freezed
class ClickReportEvent extends QuestionDetailEvent with _$ClickReportEvent {
  factory ClickReportEvent() = _ClickReportEvent;
}

@freezed
class ClickDeleteDiscusstionEvent extends QuestionDetailEvent
    with _$ClickDeleteDiscusstionEvent {
  factory ClickDeleteDiscusstionEvent(int questionId) =
      _ClickDeleteDiscusstionEvent;
}

@freezed
class PressDeleteDiscussionDetailEvent extends QuestionDetailEvent
    with _$PressDeleteDiscussionDetailEvent {
  factory PressDeleteDiscussionDetailEvent(int index) =
      _PressDeleteDiscussionDetailEvent;
}

@freezed
class ClickDownloadPhoroEvent extends QuestionDetailEvent
    with _$ClickDownloadPhoroEvent {
  factory ClickDownloadPhoroEvent(String urlImage) = _ClickDownloadPhoroEvent;
}

@freezed
class GetDiscussionByIdEvent extends QuestionDetailEvent
    with _$GetDiscussionByIdEvent {
  factory GetDiscussionByIdEvent(int id) = _GetDiscussionByIdEvent;
}

@freezed
class GetAnswerInDiscussionEvent extends QuestionDetailEvent
    with _$GetAnswerInDiscussionEvent {
  factory GetAnswerInDiscussionEvent(int id) = _GetAnswerInDiscussionEvent;
}

@freezed
class ClickLlikeComment extends QuestionDetailEvent with _$ClickLlikeComment {
  factory ClickLlikeComment(int answerIndex, int commentIndex) =
      _ClickLlikeComment;
}

@freezed
class ClickDeleteComment extends QuestionDetailEvent with _$ClickDeleteComment {
  factory ClickDeleteComment(int answerIndex, int commentIndex) =
      _ClickDeleteComment;
}

@freezed
class CommentMesChanged extends QuestionDetailEvent with _$CommentMesChanged {
  factory CommentMesChanged(String value) = _CommentMesChanged;
}

@freezed
class ClickReplyComment extends QuestionDetailEvent with _$ClickReplyComment {
  factory ClickReplyComment(int answerIndex, int commentIndex) = _ClickComment;
}

@freezed
class ClickAnswer extends QuestionDetailEvent with _$ClickAnswer {
  factory ClickAnswer() = _ClickAnswer;
}

@freezed
class CreateComment extends QuestionDetailEvent with _$CreateComment {
  factory CreateComment() = _CreateComment;
}

@freezed
class ClickEditComment extends QuestionDetailEvent with _$ClickEditComment {
  factory ClickEditComment(int answerIndex, int commentIndex) =
      _ClickEditComment;
}

@freezed
class ClickUpdateComment extends QuestionDetailEvent with _$ClickUpdateComment {
  factory ClickUpdateComment() = _ClickUpdateComment;
}

@freezed
class ClickCancelReply extends QuestionDetailEvent with _$ClickCancelReply {
  factory ClickCancelReply() = _ClickCancelReply;
}

@freezed
class ClickCorrent extends QuestionDetailEvent with _$ClickCorrent {
  factory ClickCorrent(BuildContext context, int index) = _ClickCorrentEvent;
}

@freezed
class ClickSeeAllCommentInQuestion extends QuestionDetailEvent
    with _$ClickSeeAllCommentInQuestion {
  factory ClickSeeAllCommentInQuestion(int questionId, BuildContext context) =
      _ClickSeeAllCommentInQuestion;
}
