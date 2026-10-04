import 'package:freezed_annotation/freezed_annotation.dart';

part 'band_permission_entity.freezed.dart';

@freezed
class bandPermissionEntity with _$bandPermissionEntity {
  const factory bandPermissionEntity({
    @Default(0) int id,
    @Default(0) int bandId,
    @Default(false) bool inviteLinkOnly,
    @Default(false) bool createQuestion,
    @Default(false) bool createDiscussion,
    @Default(false) bool addMember,
    @Default(false) bool sendMessage,
    @Default(false) bool changeInfo,
    @Default(false) bool reaction,
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _bandPermissionEntity;
}

int countTruePermissions(bandPermissionEntity entity) {
  final permissions = [
    entity.inviteLinkOnly,
    entity.createQuestion,
    entity.createDiscussion,
    entity.addMember,
    entity.sendMessage,
    entity.changeInfo,
    entity.reaction,
  ];
  return permissions.where((value) => value).length;
}
