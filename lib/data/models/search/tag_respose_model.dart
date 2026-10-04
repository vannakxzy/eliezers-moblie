import 'package:json_annotation/json_annotation.dart';
import '../meta_model.dart';

import '../../../features/search/domain/entities/tag_respose_entity.dart';
import '../post_question/tag_model.dart';

part 'tag_respose_model.g.dart';

@JsonSerializable(includeIfNull: true)
class TagResposeModel {
  TagResposeModel({
    this.data,
    this.meta,
  });

  final List<TagModel>? data;
  final MetaModel? meta;

  factory TagResposeModel.fromJson(Map<String, dynamic> json) =>
      _$TagResposeModelFromJson(json);
}

/// Map to Entity
extension TagResposeModelToEntity on TagResposeModel {
  TagResposeEntity toEntity() => TagResposeEntity(data: data ?? [], mate: meta);
}

extension TagResposeModelToListEntity on List<TagResposeModel> {
  List<TagResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
