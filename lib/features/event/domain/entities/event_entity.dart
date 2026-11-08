import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../musics/domain/entities/musics_entity.dart';
import '../../../notification/domain/entities/user_entity.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
class EventEntity with _$EventEntity {
  const factory EventEntity({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    @Default([]) List<String> covers,
    @Default('') String location,
    @Default('') String startTime,
    @Default('') String endTime,
    @Default(1) int userId,
    @Default([]) List<MusicsEntity> musics,
    @Default([]) List<UserEntity> joinedUser,
    @Default(0) double price,
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default(false) bool isjoin, 
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _EventEntity;
  factory EventEntity.fromJson(Map<String, dynamic> json) =>
      _$EventEntityFromJson(json);
}
