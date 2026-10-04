import 'package:json_annotation/json_annotation.dart';
import '../meta_model.dart';
import 'comment_model.dart';

import '../../../features/question_detail/domain/entities/comment_respose_entity.dart';

part 'comment_respose_model.g.dart';

@JsonSerializable(includeIfNull: true)
class CommentResposeModel {
  CommentResposeModel({
    this.data,
    this.meta,
  });

  final List<CommentModel>? data;
  final MetaModel? meta;

  factory CommentResposeModel.fromJson(Map<String, dynamic> json) =>
      _$CommentResposeModelFromJson(json);
}

/// Map to Entity
extension CommentResposeModelToEntity on CommentResposeModel {
  CommentResposeEntity toEntity() =>
      CommentResposeEntity(data: data ?? [], meta: meta);
}

extension CommentResposeModelToListEntity on List<CommentResposeModel> {
  List<CommentResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
