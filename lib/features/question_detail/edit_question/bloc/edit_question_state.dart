part of 'edit_question_bloc.dart';

@freezed
class EditQuestionState extends BaseState with _$EditQuestionState {
  const factory EditQuestionState({
    List<TagEntity>? tag,
    @Default([]) List<int> oldTag,
    FocusNode? focusNode,
    QuestionEntity? oldQuestion,
    QuestionEntity? question,
    @Default([]) List<TagEntity> selectTags,
    File? image,
    @Default(true) bool isValidatePost,
    @Default(false) bool isFocus,
    @Default(false) bool isLoadingCreateTag,
    @Default('') String tagtext,
    @Default('') String title,
    @Default('') String urlImage,
    @Default('') String description,
    @Default('') String audience,
    @Default(0) int questionId,
    TextEditingController? titleTextEditController,
    TextEditingController? tagTextController,
    TextEditingController? descriptionTextController,
  }) = _EditQuestionState;
}
