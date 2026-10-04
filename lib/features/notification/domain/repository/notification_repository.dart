import '../../../../data/data_sources/remotes/notification_api_service.dart';
import '../entities/notification_respose_entity.dart';

abstract class NotificationRepository {
  Future<NotificationResposeEntity> getNotification(int page);
  Future<void> deleteNotification(NotificationInput input);
  Future<void> readNotification(NotificationInput id);
  Future<void> readAll();
}
