part of 'post_question_bloc.dart';

@freezed
class PostQuestionEvent extends BaseEvent with _$PostQuestionEvent {
  const factory PostQuestionEvent.started() = _Started;
}
