part of 'post_topic_bloc.dart';

@freezed
class PostTopicEvent extends BaseEvent with _$PostTopicEvent {
  const factory PostTopicEvent.started() = _Started;
}
