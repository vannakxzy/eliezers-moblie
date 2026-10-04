import 'package:json_annotation/json_annotation.dart';
import '../meta_model.dart';
import 'notification_model.dart';

import '../../../features/notification/domain/entities/notification_respose_entity.dart';

part 'notification_respose_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NotificationResposeModel {
  NotificationResposeModel({this.data, this.meta});
  final List<NotificationModel>? data;
  final MetaModel? meta;
  factory NotificationResposeModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationResposeModelFromJson(json);
}

extension NotificationResposeModelToEntity on NotificationResposeModel {
  NotificationResposeEntity toEntity() =>
      NotificationResposeEntity(data: data, mate: meta);
}

extension NotificationResposeModelToListEntity
    on List<NotificationResposeModel> {
  List<NotificationResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
