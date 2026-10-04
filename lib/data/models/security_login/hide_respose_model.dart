// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import '../meta_model.dart';
import 'hide_model.dart';

import '../../../features/security_login/domain/entities/hide_respose_entity.dart';
part 'hide_respose_model.g.dart';

@JsonSerializable(includeIfNull: false)
class HideResposeModel {
  HideResposeModel({
    required this.meta,
    required this.data,
  });
  final List<HideModel> data;
  final MetaModel? meta;
  factory HideResposeModel.fromJson(Map<String, dynamic> json) =>
      _$HideResposeModelFromJson(json);
}

extension HideResposeModelToEntity on HideResposeModel {
  HideResposeEntity toEntity() => HideResposeEntity(
        meta: meta,
        data: data,
      );
}

extension HideResposeModelToListEntity on List<HideResposeModel> {
  List<HideResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
