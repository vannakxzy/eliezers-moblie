part of 'question_tag_bloc.dart';

@freezed
class QuestionTagState extends BaseState with _$QuestionTagState {
  const factory QuestionTagState.initial({
    @Default([]) List<QuestionEntity> questions,
    @Default(1) int page,
    @Default(true) bool loaingQuestion,
    @Default(false) bool isAnonyMous,
    @Default('') String kk,
    @Default(true) bool isMorePage,
  }) = _Initial;
}
