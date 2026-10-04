part of 'comment_in_discussion_bloc.dart';

@freezed
class CommentInDiscussionState extends BaseState
    with _$CommentInDiscussionState {
  const factory CommentInDiscussionState(
      {@Default('') String message,
      @Default('') String beforeeditMessage,
      @Default([]) List<CommentEntity> comments,
      TextEditingController? desTextController,
      @Default(false) bool isloading,
      @Default(0) int updateIndex,
      @Default('') String oldMessage,
      @Default(false) bool enableComment,
      @Default(true) bool isMorePage,
      @Default(1) int page}) = _CommentInDiscussionState;
}
