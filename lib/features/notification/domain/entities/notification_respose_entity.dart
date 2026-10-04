import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/notification/notification_model.dart';

import '../../../../data/models/meta_model.dart';

part 'notification_respose_entity.freezed.dart';

@freezed
class NotificationResposeEntity with _$NotificationResposeEntity {
  factory NotificationResposeEntity({
    List<NotificationModel>? data,
    MetaModel? mate,
  }) = _NotificationResposeEntity;
}
