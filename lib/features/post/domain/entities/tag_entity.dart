// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_entity.freezed.dart';
part 'tag_entity.g.dart';

@freezed
class TagEntity with _$TagEntity {
  factory TagEntity({
    @Default(0) int id,
    @Default('') String name,
    @Default(0) int subject_id,
    @Default(0) int question_tags_count,
  }) = _TagEntity;

  factory TagEntity.fromJson(Map<String, dynamic> json) =>
      _$TagEntityFromJson(json);
}
