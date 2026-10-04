part of 'question_detail_bloc.dart';

@freezed
class QuestionDetailState extends BaseState with _$QuestionDetailState {
  const factory QuestionDetailState({
    @Default(false) bool isloading,
    @Default(QuestionEntity()) QuestionEntity question,
    @Default([]) List<AnswertEntity> answer,
    @Default(true) bool isMorePage,
    @Default(true) bool isScrollingDown,
    @Default(1) int page,
    @Default(0) int updateIndex,
    @Default('') String oldMessage,
    @Default(false) bool enableAnswer,
    @Default(false) bool showBackground,
    @Default('') String message,
    @Default('') String beforeeditMessage,
    TextEditingController? messageController,
    @Default('') String urlImage,
    File? file,
    @Default(false) bool isComment,
    // for comment
    @Default(0) int answerIndex,
    @Default(false) bool enableComment,
    @Default('') String replyTo,
  }) = _Initial;
}
