import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../repository/event_repository.dart';

@Injectable()
class DeleteEventUseCase extends BaseUseCase<int, void> {
  final EventRepository _eventRepository;
  DeleteEventUseCase(this._eventRepository);
  @override
  Future<void> excecute(int input) async {
    return await _eventRepository.deleteEvent(input);
  }
}
