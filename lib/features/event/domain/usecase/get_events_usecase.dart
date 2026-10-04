import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../entities/event_respose_entity.dart';
import '../repository/event_repository.dart';

@Injectable()
class GetEventsUsecase extends BaseUseCase<int, EventResposeEntity> {
  final EventRepository _EventRepository;
  GetEventsUsecase(this._EventRepository);
  @override
  Future<EventResposeEntity> excecute(int input) async {
    return await _EventRepository.getEvents(input);
  }
}
