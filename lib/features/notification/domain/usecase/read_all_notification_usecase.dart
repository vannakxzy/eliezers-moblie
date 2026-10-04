import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/notification_repository.dart';

@Injectable()
class ReadAllNotificationUsecase extends BaseUseCase<void, void> {
  final NotificationRepository _notificationRepository;
  ReadAllNotificationUsecase(this._notificationRepository);

  @override
  Future excecute(input) async {
    return await _notificationRepository.readAll();
  }
}
