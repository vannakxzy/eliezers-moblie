// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/band/domain/entities/band_member_entity.dart';
import '../profile/profile_model.dart';
import 'band_model.dart';
part 'band_member_model.g.dart';

@JsonSerializable()
class BandMemberModel {
  BandMemberModel({
    required this.id,
    required this.status,
    required this.user,
    required this.role,
    required this.createAt,
    required this.band,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'createdAt')
  final String? createAt;
  @Default(ProfileModel())
  ProfileModel user;
  @Default(BandModel())
  BandModel band;

  factory BandMemberModel.fromJson(Map<String, dynamic> json) =>
      _$BandMemberModelFromJson(json);
  Map<String, dynamic> toJson() => _$BandMemberModelToJson(this);
}

extension BandModelToEntity on BandMemberModel {
  bandMemberEntity toEntity() => bandMemberEntity(
        id: id ?? 0,
        status: status ?? '',
        createAt: createAt ?? '',
        role: role ?? "",
        user: user.toEntity(),
        band: band.toEntity(),
      );
}

extension BandModelToListEntity on List<BandMemberModel> {
  List<bandMemberEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
