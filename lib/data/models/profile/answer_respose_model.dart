import 'package:json_annotation/json_annotation.dart';
import '../meta_model.dart';
import 'answer_model.dart';

import '../../../features/profile/domain/entities/answer_respose_entity.dart';

part 'answer_respose_model.g.dart';

@JsonSerializable(includeIfNull: true)
class AnswerResposeModel {
  AnswerResposeModel({
    this.data,
    this.meta,
  });

  final List<AnswerModel>? data;
  final MetaModel? meta;

  factory AnswerResposeModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerResposeModelFromJson(json);
}

/// Map to Entity
extension AnswerResposeModelToEntity on AnswerResposeModel {
  AnswerResposeEntity toEntity() =>
      AnswerResposeEntity(data: data ?? [], mate: meta);
}

extension AnswerResposeModelToListEntity on List<AnswerResposeModel> {
  List<AnswerResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
