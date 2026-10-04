import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/event/domain/entities/event_entity.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  EventModel({
    this.id,
    this.title,
    this.content,
    this.cover,
    this.location,
    this.startTime,
    this.endTime,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.isJoin,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'cover')
  final String? cover;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'start_time')
  final String? startTime;
  @JsonKey(name: "is_join")
  final bool? isJoin;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final double? price;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}

extension EventModelToEnity on EventModel {
  EventEntity toEntity() => EventEntity(
      content: content ?? "",
      cover: cover ?? "",
      title: title ?? "",
      location: location ?? "",
      startTime: startTime ?? "",
      endTime: endTime ?? "",
      isJoin: isJoin ?? false,
      price: price ?? 0);
}

extension QuestionModelToListEntity on List<EventModel> {
  List<EventEntity> toListEntity() => map((model) => model.toEntity()).toList();
}
