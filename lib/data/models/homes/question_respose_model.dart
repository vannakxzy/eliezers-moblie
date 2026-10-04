import 'package:json_annotation/json_annotation.dart';
import '../meta_model.dart';
import '../question_model.dart';

import '../../../features/home/domain/entities/question_respose_entity.dart';

part 'question_respose_model.g.dart';

@JsonSerializable(includeIfNull: true)
class QuestionResposeModel {
  QuestionResposeModel({
    this.data,
    this.meta,
  });

  final List<QuestionModel>? data;
  final MetaModel? meta;

  factory QuestionResposeModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionResposeModelFromJson(json);
}

extension QuestionResposeModelToEntity on QuestionResposeModel {
  QuestionResposeEntity toEntity() =>
      QuestionResposeEntity(data: data ?? [], mate: meta);
}

extension QuestionResposeModelToListEntity on List<QuestionResposeModel> {
  List<QuestionResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
