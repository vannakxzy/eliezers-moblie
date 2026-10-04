part of 'data_tag_question_bloc.dart';

@freezed
class DataTagQuestionState extends BaseState with _$DataTagQuestionState {
  const factory DataTagQuestionState({
    @Default([]) List<List<QuestionEntity>> question,
    @Default([]) List<bool> isloading,
    @Default([]) List<bool> isMorePage,
    @Default([]) List<int> page,
  }) = _Initial;
}
