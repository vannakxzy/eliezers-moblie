part of 'comment_in_question_bloc.dart';

@freezed
class CommentInQuestionState extends BaseState with _$CommentInQuestionState {
  const factory CommentInQuestionState.initial(
      {@Default([]) List<CommentEntity> comments,
      @Default(true) bool getLoadingComment,
      @Default('') String message,
      @Default('') String beforeeditMessage,
      @Default(0) int userId,
      TextEditingController? desTextController,
      @Default(0) int updateIndex,
      @Default(0) int valueUpdated,
      @Default('') String oldMessage,
      @Default(false) bool enableComment,
      @Default(true) bool isMorePage,
      @Default(1) int page}) = _Initial;
}
