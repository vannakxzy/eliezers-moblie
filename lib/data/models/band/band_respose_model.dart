import 'package:json_annotation/json_annotation.dart';
import '../../../features/band/domain/entities/band_respose_entity.dart';
import '../meta_model.dart';
import 'band_model.dart';

part 'band_respose_model.g.dart';

@JsonSerializable(includeIfNull: true)
class bandResposeModel {
  bandResposeModel({
    this.data,
    this.meta,
  });

  final List<BandModel>? data;
  final PaginationModel? meta;

  factory bandResposeModel.fromJson(Map<String, dynamic> json) =>
      _$bandResposeModelFromJson(json);
}

/// Map to Entity
extension BandResposeModelToEntity on bandResposeModel {
  BandResposeEntity toEntity() =>
      BandResposeEntity(data: data ?? [], pagination: meta);
}

extension BandResposeModelToListEntity on List<bandResposeModel> {
  List<BandResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
