import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/event/domain/entities/event_entity.dart';
import '../../../features/musics/domain/entities/musics_entity.dart';
import '../../../features/notification/domain/entities/user_entity.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  EventModel({
    this.id,
    this.title,
      this.description,
    this.cover,
    this.location,
    this.startTime,
    this.endTime,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.price,
      this.isjoin,
      this.joined_user,
      this.musics,
      this.covers,
      this.latitude,
      this.longitude
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'cover')
  final String? cover;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'start_time')
  final String? startTime;
  @JsonKey(name: "is_join")
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final double? price;
  final double? latitude;
  final double? longitude;
  final List<String>? covers;
  final bool? isjoin;
  final List<MusicsEntity>? musics;
  final List<UserEntity>? joined_user;
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}

extension EventModelToEnity on EventModel {
  EventEntity toEntity() => EventEntity(
      description: description ?? "",
      title: title ?? "",
      id: id ?? 0,
      location: location ?? "",
      startTime: startTime ?? "",
      endTime: endTime ?? "",
      isjoin: isjoin ?? false,
      price: price ?? 0,
      covers: covers ?? [],
      joinedUser: joined_user ?? [],
      longitude: longitude ?? 0,
      latitude: latitude ?? 0,
      musics: musics ?? []);
}

extension QuestionModelToListEntity on List<EventModel> {
  List<EventEntity> toListEntity() => map((model) => model.toEntity()).toList();
}
