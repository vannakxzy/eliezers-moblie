import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/notification_api_service.dart';
import '../repository/notification_repository.dart';

@Injectable()
class ReadNotificationUsecase extends BaseUseCase<NotificationInput, void> {
  final NotificationRepository _notificationRepository;
  ReadNotificationUsecase(this._notificationRepository);

  @override
  Future excecute(input) async {
    return await _notificationRepository.readNotification(input);
  }
}
