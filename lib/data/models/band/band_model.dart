// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/band/domain/entities/band_entity.dart';

part 'band_model.g.dart';

@JsonSerializable()
class BandModel {
  const BandModel({
    this.id,
    this.name,
    this.description,
    this.cover,
    this.isPublic,
    this.question,
    this.discussion,
    //   this.inviteLikeOnly,
    // this.createdAt,
    // this.owner,
    // this.unread,
    // this.status,
    // this.updatedAt,
    //  this.permission,
    // this.yourRole,
    //     this.member,

    // this.administoator,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  final int? question;
  final int? discussion;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'cover')
  final String? cover;

  @JsonKey(name: 'is_public')
  final bool? isPublic;

  // @JsonKey(name: 'member')
  // final int? member;
  // @JsonKey(name: 'unread')
  // final int? unread;
  // @JsonKey(name: 'administoator')
  // final int? administoator;
  // @JsonKey(name: 'your_role')
  // final String? yourRole;

  // @JsonKey(name: 'invite_like_only')
  // final bool? inviteLikeOnly;

  // @JsonKey(name: 'created_at')
  // final String? createdAt;

  // @JsonKey(name: 'updated_at')
  // final String? updatedAt;
  // @JsonKey(name: 'owner')
  // final ProfileModel? owner;

  // final BandPermissionModel? permission;

  // @JsonKey(name: 'status')
  // final String? status;

  factory BandModel.fromJson(Map<String, dynamic> json) =>
      _$BandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BandModelToJson(this);
}

extension BandModelToEntity on BandModel {
  BandEntity toEntity() => BandEntity(
        id: id ?? 0,
        name: name ?? '',
        description: description ?? '',
        cover: cover ?? '',
        isPublic: isPublic ?? false,
        // member: member ?? 0,
        // inviteLikeOnly: inviteLikeOnly ?? false,
        // createdAt: createdAt ?? '',
        // owner: owner?.toEntity() ?? ProfileEntity(),
        // permission: permission?.toEntity() ?? bandPermissionEntity(),
        // status: status ?? '',
        // yourRole: yourRole ?? '',
        // question: question ?? 0,
        // unread: unread ?? 0,
        // updatedAt: updatedAt ?? "",
        // discussion: discussion ?? 0,
        // administoator: administoator ?? 0,
      );
}

extension BandModelToListEntity on List<BandModel> {
  List<BandEntity> toListEntity() => map((model) => model.toEntity()).toList();
}
