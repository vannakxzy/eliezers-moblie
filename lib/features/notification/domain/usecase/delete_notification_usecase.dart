import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/notification_repository.dart';

import '../../../../data/data_sources/remotes/notification_api_service.dart';

@Injectable()
class DeleteNotificationUsecase extends BaseUseCase<NotificationInput, void> {
  final NotificationRepository _notificationRepository;
  DeleteNotificationUsecase(this._notificationRepository);

  @override
  Future excecute(input) async {
    return await _notificationRepository.deleteNotification(input);
  }
}
