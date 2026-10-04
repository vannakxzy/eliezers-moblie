// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import '../../../features/notification/domain/entities/user_entity.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({required super.id, required super.avatar, required super.name});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
