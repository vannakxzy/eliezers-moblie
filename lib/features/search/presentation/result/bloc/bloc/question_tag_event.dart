part of 'question_tag_bloc.dart';

class QuestionTagEvent extends BaseEvent {}

@freezed
class GetQuestion extends QuestionTagEvent with _$GetQuestion {
  factory GetQuestion(int tagId) = _GetQuestion;
}

@freezed
class ClickSaveQuestionT extends QuestionTagEvent with _$ClickSaveQuestionT {
  factory ClickSaveQuestionT(int index) = _ClickSaveQuestionT;
}

@freezed
class OnRefreshPageEvent extends QuestionTagEvent with _$OnRefreshPageEvent {
  factory OnRefreshPageEvent(int tagId) = _OnRefreshPageEvent;
}

@freezed
class ClickQuestionEvent extends QuestionTagEvent with _$ClickQuestionEvent {
  factory ClickQuestionEvent(QuestionEntity question, int id) =
      _ClickQuestionEvent;
}

@freezed
class ClickHideEventp extends QuestionTagEvent with _$ClickHideEventp {
  factory ClickHideEventp(int index) = _ClickHideEventp;
}

@freezed
class ClickUnHideEventT extends QuestionTagEvent with _$ClickUnHideEventT {
  factory ClickUnHideEventT(int index) = _ClickUnHideEventT;
}

@freezed
class ClickLikeEventT extends QuestionTagEvent with _$ClickLikeEventT {
  factory ClickLikeEventT(int index) = _ClickLikeEventT;
}

@freezed
class ClickOnUser extends QuestionTagEvent with _$ClickOnUser {
  factory ClickOnUser(int id) = _ClickOnUser;
}

@freezed
class ClickShareQuestion extends QuestionTagEvent with _$ClickShareQuestion {
  factory ClickShareQuestion(QuestionEntity question) = _ClickShareQuestion;
}
