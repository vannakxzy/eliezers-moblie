// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/band/domain/entities/band_permission_entity.dart';

part 'band_permission_model.g.dart';

@JsonSerializable()
class BandPermissionModel {
  BandPermissionModel(
      this.id,
      this.bandId,
      this.inviteLinkOnly,
      this.createQuestion,
      this.createDiscussion,
      this.addMember,
      this.sendMessage,
      this.changeInfo,
      this.reaction,
      this.createdAt,
      this.updatedAt);
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'band_id')
  final int? bandId;
  @JsonKey(name: 'invite_link_only')
  final bool? inviteLinkOnly;
  @JsonKey(name: 'create_question')
  final bool? createQuestion;
  @JsonKey(name: 'create_discussion')
  final bool? createDiscussion;
  @JsonKey(name: 'add_member')
  final bool? addMember;
  @JsonKey(name: 'send_message')
  final bool? sendMessage;
  @JsonKey(name: 'change_info')
  final bool? changeInfo;
  @JsonKey(name: 'reaction')
  final bool? reaction;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  factory BandPermissionModel.fromJson(Map<String, dynamic> json) =>
      _$BandPermissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$BandPermissionModelToJson(this);
}

extension BandModelToEntity on BandPermissionModel {
  bandPermissionEntity toEntity() => bandPermissionEntity(
      addMember: addMember ?? false,
      changeInfo: changeInfo ?? false,
      bandId: bandId ?? 0,
      id: id ?? 0,
      createDiscussion: createDiscussion ?? false,
      inviteLinkOnly: inviteLinkOnly ?? false,
      createQuestion: createQuestion ?? false,
      reaction: reaction ?? false,
      sendMessage: sendMessage ?? false,
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '');
}

extension BandModelToListEntity on List<BandPermissionModel> {
  List<bandPermissionEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
