import 'package:json_annotation/json_annotation.dart';
import '../../../features/musics/domain/entities/music_respose_entity.dart';
import '../meta_model.dart';
import 'musics_model.dart';

part 'musics_respose_model.g.dart';

@JsonSerializable(includeIfNull: true)
class MusicsResposeModel {
  MusicsResposeModel({
    this.data,
    this.pagination,
  });

  final List<MusicsModel>? data;
  final PaginationModel? pagination;

  factory MusicsResposeModel.fromJson(Map<String, dynamic> json) =>
      _$MusicsResposeModelFromJson(json);
}

extension MusicsResposeModelToEntity on MusicsResposeModel {
  MusicsResposeEntity toEntity() =>
      MusicsResposeEntity(data: data ?? [], pagination: pagination);
}

extension MusicsResposeModelToListEntity on List<MusicsResposeModel> {
  List<MusicsResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
