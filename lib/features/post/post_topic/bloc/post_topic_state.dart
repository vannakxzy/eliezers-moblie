part of 'post_topic_bloc.dart';

@freezed
class PostTopicState extends BaseState with _$PostTopicState {
  const factory PostTopicState({
    String? title,
  }) = _PostTopicState;
}
