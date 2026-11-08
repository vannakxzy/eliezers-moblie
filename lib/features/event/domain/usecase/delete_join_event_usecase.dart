import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../repository/event_repository.dart';

@Injectable()
class DeleteJoinEventUsecase extends BaseUseCase<int, void> {
  final EventRepository _eventRepository;
  DeleteJoinEventUsecase(this._eventRepository);
  @override
  Future<void> excecute(int input) async {
    return await _eventRepository.deleteBooking(input);
  }
}
