import 'package:json_annotation/json_annotation.dart';

import '../../../features/create_account/domain/entities/avatar_entity.dart';

part 'avatar_model.g.dart';

@JsonSerializable(createToJson: true)
class AvatarModel extends AvartaEntity {
  AvatarModel({required super.id, required super.name});
  factory AvatarModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarModelFromJson(json);
}
