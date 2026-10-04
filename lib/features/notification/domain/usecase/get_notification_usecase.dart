import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/notification_respose_entity.dart';
import '../repository/notification_repository.dart';

@Injectable()
class GetNotificationUsecase
    extends BaseUseCase<int, NotificationResposeEntity> {
  final NotificationRepository _repository;
  GetNotificationUsecase(this._repository);
  @override
  Future<NotificationResposeEntity> excecute(int input) async {
    return await _repository.getNotification(1);
  }
}
