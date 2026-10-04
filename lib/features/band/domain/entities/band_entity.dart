import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../profile/domain/entities/profile_entity.dart';
import 'band_permission_entity.dart';

part 'band_entity.freezed.dart';
part 'band_entity.g.dart';

@freezed
class BandEntity with _$BandEntity {
  const factory BandEntity({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String cover,
    @Default(false) bool isPublic,

    ///
    @JsonKey(ignore: true) @Default(0) int member,
    @JsonKey(ignore: true) @Default(0) int administoator,
    @JsonKey(ignore: true) @Default(0) int question,
    @JsonKey(ignore: true) @Default(0) int discussion,
    @JsonKey(ignore: true) @Default(0) int unread,
    @JsonKey(ignore: true) @Default(false) bool inviteLikeOnly,
    @JsonKey(ignore: true) @Default('') String yourRole,
    @JsonKey(ignore: true) @Default('') String createdAt,
    @JsonKey(ignore: true) @Default('') String updatedAt,
    @JsonKey(ignore: true)
    @JsonKey(ignore: true)
    @JsonKey(ignore: true)
    @Default(bandPermissionEntity())
    @JsonKey(ignore: true)
    bandPermissionEntity permission,
    @JsonKey(ignore: true) @Default(ProfileEntity()) ProfileEntity owner,
    @JsonKey(ignore: true) @Default('') String status,
    @JsonKey(ignore: true) @Default(true) isCreated,
  }) = _BandEntity;

  factory BandEntity.fromJson(Map<String, dynamic> json) =>
      _$BandEntityFromJson(json);
}
