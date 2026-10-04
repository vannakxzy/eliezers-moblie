part of 'all_question_bloc.dart';

abstract class AllQuestionEvent extends BaseEvent {}

@freezed
class GetQuestionEvent extends AllQuestionEvent with _$GetQuestionEvent {
  factory GetQuestionEvent(int userId) = _GetQuestionEvent;
}

@freezed
class RefreshPage extends AllQuestionEvent with _$RefreshPage {
  factory RefreshPage(int userId) = _RefreshPage;
}

@freezed
class ClickHideEvent extends AllQuestionEvent with _$ClickHideEvent {
  factory ClickHideEvent(int index) = _ClickHideEvent;
}

@freezed
class ClickUnHideEvent extends AllQuestionEvent with _$ClickUnHideEvent {
  factory ClickUnHideEvent(int index) = _ClickUnHideEvent;
}

@freezed
class ClickLikeEvent extends AllQuestionEvent with _$ClickLikeEvent {
  factory ClickLikeEvent(int index) = _ClickLikeEvent;
}

@freezed
class ClickDoubleTapEvent extends AllQuestionEvent with _$ClickDoubleTapEvent {
  factory ClickDoubleTapEvent(int index) = _ClickDoubleTapEvent;
}

@freezed
class ClickQuestionEvent extends AllQuestionEvent with _$ClickQuestionEvent {
  factory ClickQuestionEvent(int id, QuestionEntity questionEntity) =
      _ClickQuestionEvent;
}

@freezed
class ClickShareQuestion extends AllQuestionEvent with _$ClickShareQuestion {
  factory ClickShareQuestion(QuestionEntity question) = _ClickShareQuestion;
}
