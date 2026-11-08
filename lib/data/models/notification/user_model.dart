
import 'package:json_annotation/json_annotation.dart';

import '../../../features/notification/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    this.id,
    this.name,
    this.avatar,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'avatar')
  final String? avatar;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelToEntity on UserModel {
  UserEntity toEntity() => UserEntity(
        id: id ?? 1,
        name: name ?? '',
        avatar: avatar ?? '',
      );
}

extension UserModelToListEntity on List<UserModel> {
  List<UserEntity> toListEntity() => map((model) => model.toEntity()).toList();
}
