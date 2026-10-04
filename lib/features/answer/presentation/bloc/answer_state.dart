part of 'answer_bloc.dart';

@freezed
class AnswerState extends BaseState with _$AnswerState {
  const factory AnswerState({
    @Default('') String message,
    @Default('') String beforeeditMessage,
    TextEditingController? messageController,
    File? image,
    @Default('') String urlImage,
    @Default(true) bool isloading,
    @Default(false) bool isComment,
    @Default(false) bool enableAnswer,
    @Default(false) bool isScrollingDown,
    @Default([]) List<AnswertEntity> answer,
    @Default(0) int updateIndex,
    @Default('') String oldMessage,
    AnswertEntity? editAnswerEntity,
    AnswertEntity? oldAnswerEntity,
    @Default(true) bool isMorePage,
    @Default(1) int page,
    // for comment
    @Default(0) int answerIndex,
    @Default(false) bool enableComment,
    @Default('') String replyTo,

    // TextEditingController? desTextController,
  }) = _AnswerState;
}
