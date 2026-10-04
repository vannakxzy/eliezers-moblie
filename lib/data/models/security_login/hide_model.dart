// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/security_login/domain/entities/hide_entity.dart';
import '../question_model.dart';
part 'hide_model.g.dart';

@JsonSerializable(includeIfNull: false)
class HideModel {
  HideModel({
    required this.date,
    required this.id,
    required this.data,
  });
  final QuestionModel? data;
  final int? id;
  final String? date;
  factory HideModel.fromJson(Map<String, dynamic> json) =>
      _$HideModelFromJson(json);
}

extension HideModelToEntity on HideModel {
  HideEntity toEntity() => HideEntity(
        id: id,
        date: date!,
        data: data,
      );
}

extension HideModelToListEntity on List<HideModel> {
  List<HideEntity> toListEntity() => map((model) => model.toEntity()).toList();
}
