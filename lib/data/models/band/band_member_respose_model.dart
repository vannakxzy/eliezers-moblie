import 'package:json_annotation/json_annotation.dart';
import '../../../features/band/domain/entities/band_member_respose_entity.dart';
import '../meta_model.dart';
import 'band_member_model.dart';

part 'band_member_respose_model.g.dart';

@JsonSerializable(includeIfNull: true)
class BandMemberResposeModel {
  BandMemberResposeModel({
    this.data,
    this.meta,
  });

  final List<BandMemberModel>? data;
  final MetaModel? meta;

  factory BandMemberResposeModel.fromJson(Map<String, dynamic> json) =>
      _$BandMemberResposeModelFromJson(json);
}

/// Map to Entity
extension BandResposeModelToEntity on BandMemberResposeModel {
  BandMemberResposeEntity toEntity() =>
      BandMemberResposeEntity(data: data ?? [], mate: meta);
}

extension BandResposeModelToListEntity on List<BandMemberResposeModel> {
  List<BandMemberResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
