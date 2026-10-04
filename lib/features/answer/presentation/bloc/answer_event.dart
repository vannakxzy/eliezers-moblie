part of 'answer_bloc.dart';

abstract class AnswerEvent extends BaseEvent {}

@freezed
class GetAnswerEvent extends AnswerEvent with _$GetAnswerEvent {
  factory GetAnswerEvent(int questionId) = _GetAnswerEvent;
}

@freezed
class ClcikCreateAnswerEvent extends AnswerEvent with _$ClcikCreateAnswerEvent {
  factory ClcikCreateAnswerEvent(int questionId, int bandId) =
      _ClcikCreateAnswerEvent;
}

@freezed
class DescriptionChangedEvent extends AnswerEvent
    with _$DescriptionChangedEvent {
  factory DescriptionChangedEvent(String text) = _DescriptionChangedEvent;
}

@freezed
class ClickPickImageEvent extends AnswerEvent with _$ClickPickImageEvent {
  factory ClickPickImageEvent(File file) = _ClickPickImageEvent;
}

@freezed
class RefreshPage extends AnswerEvent with _$RefreshPage {
  factory RefreshPage(int questionId) = _RefreshPage;
}

@freezed
class ClickClearImageEvent extends AnswerEvent with _$ClickClearImageEvent {
  factory ClickClearImageEvent() = _ClickClearImageEvent;
}

@freezed
class ClickProfileEvent extends AnswerEvent with _$ClickProfileEvent {
  factory ClickProfileEvent(int userId) = _ClickProfileEvent;
}

@freezed
class ClickCorrentEvent extends AnswerEvent with _$ClickCorrentEvent {
  factory ClickCorrentEvent(BuildContext context, int index) =
      _ClickCorrentEvent;
}

@freezed
class ClickLikeEvent extends AnswerEvent with _$ClickLikeEvent {
  factory ClickLikeEvent(int index) = _ClickLikeEvent;
}

@freezed
class ClickDeleteEvent extends AnswerEvent with _$ClickDeleteEvent {
  factory ClickDeleteEvent(BuildContext context, int index) = _ClickDeleteEvent;
}

@freezed
class ClickEditEvent extends AnswerEvent with _$ClickEditEvent {
  factory ClickEditEvent(int index) = _ClcikEditEvent;
}

@freezed
class ClickCancelEditEvent extends AnswerEvent with _$ClickCancelEditEvent {
  factory ClickCancelEditEvent() = _ClickCancelEditEvent;
}

@freezed
class ClickUpdateEvent extends AnswerEvent with _$ClickUpdateEvent {
  factory ClickUpdateEvent() = _ClickUpdateEvent;
}

@freezed
class ClickDownloadImage extends AnswerEvent with _$ClickDownloadImage {
  factory ClickDownloadImage(String image) = _ClickDownloadImage;
}

@freezed
class ClickGetComment extends AnswerEvent with _$ClickGetComment {
  factory ClickGetComment(int index) = _ClickGetComment;
}

@freezed
class ClickLlikeComment extends AnswerEvent with _$ClickLlikeComment {
  factory ClickLlikeComment(int answerIndex, int commentIndex) =
      _ClickLlikeComment;
}

@freezed
class ClickDeleteComment extends AnswerEvent with _$ClickDeleteComment {
  factory ClickDeleteComment(int answerIndex, int commentIndex) =
      _ClickDeleteComment;
}

@freezed
class CommentMesChanged extends AnswerEvent with _$CommentMesChanged {
  factory CommentMesChanged(String value) = _CommentMesChanged;
}

@freezed
class ClickReplyComment extends AnswerEvent with _$ClickReplyComment {
  factory ClickReplyComment(int answerIndex, int commentIndex) = _ClickComment;
}

@freezed
class ClickAnswer extends AnswerEvent with _$ClickAnswer {
  factory ClickAnswer() = _ClickAnswer;
}

@freezed
class CreateComment extends AnswerEvent with _$CreateComment {
  factory CreateComment() = _CreateComment;
}

@freezed
class ClickEditComment extends AnswerEvent with _$ClickEditComment {
  factory ClickEditComment(int answerIndex, int commentIndex) =
      _ClickEditComment;
}

@freezed
class ClickUpdateComment extends AnswerEvent with _$ClickUpdateComment {
  factory ClickUpdateComment() = _ClickUpdateComment;
}

@freezed
class ClickCancelReply extends AnswerEvent with _$ClickCancelReply {
  factory ClickCancelReply() = _ClickCancelReply;
}

@freezed
class ScrollDirectionUpdate extends AnswerEvent with _$ScrollDirectionUpdate {
  factory ScrollDirectionUpdate(bool value) = _ScrollDirectionUpdate;
}
