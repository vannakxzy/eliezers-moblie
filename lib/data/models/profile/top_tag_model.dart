import 'package:json_annotation/json_annotation.dart';

import '../../../features/profile/domain/entities/top_tag_entity.dart';
part 'top_tag_model.g.dart';

@JsonSerializable()
class TopTagModel extends TopTagEntity {
  TopTagModel({required super.count, required super.id, required super.name});

  factory TopTagModel.fromJson(Map<String, dynamic> json) =>
      _$TopTagModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopTagModelToJson(this);
}
