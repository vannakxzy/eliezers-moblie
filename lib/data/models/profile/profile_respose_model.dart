import 'package:json_annotation/json_annotation.dart';
import '../meta_model.dart';
import 'profile_model.dart';
import '../../../features/profile/domain/entities/profile_respose_entity.dart';

part 'profile_respose_model.g.dart';

@JsonSerializable(includeIfNull: true)
class ProfileResposeModel {
  ProfileResposeModel({
    this.data,
    this.meta,
  });

  final List<ProfileModel>? data;
  final MetaModel? meta;

  factory ProfileResposeModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResposeModelFromJson(json);
}

/// Map to Entity
extension ProfileResposeModelToEntity on ProfileResposeModel {
  ProfileResposeEntity toEntity() =>
      ProfileResposeEntity(data: data ?? [], mate: meta);
}

extension ProfileResposeModelToListEntity on List<ProfileResposeModel> {
  List<ProfileResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
