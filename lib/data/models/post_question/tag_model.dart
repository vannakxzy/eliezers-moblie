// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../../../features/post/domain/entities/tag_entity.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class TagModel {
  const TagModel({
    required this.id,
    required this.name,
    this.subject_id = 0,
    this.question_tags_count = 0,
  });

  final int id;
  final String name;

  @JsonKey(name: 'subject_id')
  final int subject_id;

  @JsonKey(name: 'question_tags_count')
  final int question_tags_count;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}

extension ToEntity on TagModel {
  TagEntity toEntity() => TagEntity(
        id: id,
        name: name,
        subject_id: subject_id,
        question_tags_count: question_tags_count,
      );
}

extension TagModelToListEntity on List<TagModel> {
  List<TagEntity> toListEntity() => map((tag) => tag.toEntity()).toList();
}
