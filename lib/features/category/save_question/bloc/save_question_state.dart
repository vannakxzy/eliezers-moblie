part of 'save_question_bloc.dart';

@freezed
class SaveQuestionState extends BaseState with _$SaveQuestionState {
  const factory SaveQuestionState({
    @Default(true) bool isloading,
    @Default([]) List<CategoryEntity> category,
  }) = _SaveQuestionState;
}
