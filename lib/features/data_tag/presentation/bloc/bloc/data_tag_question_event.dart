part of 'data_tag_question_bloc.dart';

abstract class DataTagQuestionEvent extends BaseEvent {}

@freezed
abstract class GetQuestionEventq extends DataTagQuestionEvent
    with _$GetQuestionEventq {
  factory GetQuestionEventq({
    required int index,
    required int userId,
    required int tagId,
  }) = _GetQuestionEventq;
}

@freezed
class InitPage extends DataTagQuestionEvent with _$InitPage {
  factory InitPage({
    required List<TopTagEntity> tag,
    required int index,
  }) = _InitPage;
}

@freezed
class ClickQuestionEvetn extends DataTagQuestionEvent
    with _$ClickQuestionEvetn {
  factory ClickQuestionEvetn(QuestionEntity question, int id) =
      _ClickQuestionEvetn;
}

@freezed
class RefreshPaged extends DataTagQuestionEvent with _$RefreshPaged {
  factory RefreshPaged({
    required int index,
    required int userId,
    required int tagId,
  }) = _RefreshPaged;
}

@freezed
class DoubleTapEvent extends DataTagQuestionEvent with _$DoubleTapEvent {
  factory DoubleTapEvent(int tap, int index) = _DoubleTapEvent;
}

@freezed
class ClickHideEvent extends DataTagQuestionEvent with _$ClickHideEvent {
  factory ClickHideEvent(int tap, int index) = _ClickHideEvent;
}

@freezed
class ClickUnHideEvent extends DataTagQuestionEvent with _$ClickUnHideEvent {
  factory ClickUnHideEvent(int tap, int index) = _ClickUnHideEvent;
}

@freezed
class ClickLikeEvent extends DataTagQuestionEvent with _$ClickLikeEvent {
  factory ClickLikeEvent(int tap, int index) = _ClickLikeEvent;
}

@freezed
class ClickSaveQuesition extends DataTagQuestionEvent
    with _$ClickSaveQuesition {
  factory ClickSaveQuesition(int tap, int index) = _ClickSaveQuesition;
}

@freezed
class ClickShare extends DataTagQuestionEvent with _$ClickShare {
  factory ClickShare(QuestionEntity question) = _ClickShare;
}
