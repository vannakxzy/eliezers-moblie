// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import '../meta_model.dart';
import 'block_model.dart';
import '../../../features/security_login/domain/entities/block_respnose_entity.dart';

part 'block_respose_model.g.dart';

@JsonSerializable(includeIfNull: false)
class BlockResposeModel {
  BlockResposeModel({
    required this.meta,
    required this.data,
  });
  final List<BlockModel> data;
  final MetaModel? meta;
  factory BlockResposeModel.fromJson(Map<String, dynamic> json) =>
      _$BlockResposeModelFromJson(json);
}

extension BlockResposeModelToEntity on BlockResposeModel {
  BlockRespnoseEntity toEntity() => BlockRespnoseEntity(
        meta: meta,
        data: data,
      );
}

extension BlockResposeModelToListEntity on List<BlockResposeModel> {
  List<BlockRespnoseEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
