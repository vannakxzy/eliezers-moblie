import 'package:injectable/injectable.dart';
import '../data_sources/remotes/notification_api_service.dart';
import '../../features/notification/domain/entities/notification_respose_entity.dart';

import '../../features/notification/domain/repository/notification_repository.dart';
import '../models/notification/notification_respose_model.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApiService _apiService;
  NotificationRepositoryImpl(this._apiService);

  @override
  Future<void> deleteNotification(NotificationInput input) async {
    return await _apiService.deleteNotification(input);
  }

  @override
  Future<NotificationResposeEntity> getNotification(int page) async {
    final data = await _apiService.getNotification(id: page);
    return data.toEntity();
  }

  @override
  Future<void> readNotification(NotificationInput input) async {
    await _apiService.readNotification(input);
  }

  @override
  Future<void> readAll() async {
    await _apiService.readAll();
  }
}
