// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/security_login/domain/entities/block_entity.dart';

part 'block_model.g.dart';

@JsonSerializable(includeIfNull: false)
class BlockModel {
  BlockModel(
      {required this.name,
      required this.profile,
      required this.user_name,
      required this.date,
      required this.id});
  final int? id;
  final String? date;
  final String? name;
  final String? profile;
  final String? user_name;
  factory BlockModel.fromJson(Map<String, dynamic> json) =>
      _$BlockModelFromJson(json);
}

extension BlockModelToEntity on BlockModel {
  BlockEntity toEntity() => BlockEntity(
      id: id ?? 0,
      date: date!,
      name: name ?? "",
      profile: profile ?? "",
      user_name: user_name ?? "");
}

extension BlockModelToListEntity on List<BlockModel> {
  List<BlockEntity> toListEntity() => map((model) => model.toEntity()).toList();
}
