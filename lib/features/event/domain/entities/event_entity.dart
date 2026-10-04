import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
class EventEntity with _$EventEntity {
  const factory EventEntity({
    @Default(1) int id,
    @Default('') String title,
    @Default('') String content,
    @Default('') String cover,
    @Default('') String location,
    @Default('') String startTime,
    @Default('') String endTime,
    @Default(1) int userId,
    @Default(0) double price,
    @Default(false) bool isJoin,
    @Default('') String createdAt,
    @Default('') String? updatedAt,
  }) = _EventEntity;
  factory EventEntity.fromJson(Map<String, dynamic> json) =>
      _$EventEntityFromJson(json);
}
