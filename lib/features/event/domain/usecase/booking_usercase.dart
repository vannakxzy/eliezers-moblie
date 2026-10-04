import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../repository/event_repository.dart';

@Injectable()
class BookingUsecase extends BaseUseCase<int, void> {
  final EventRepository _EventRepository;
  BookingUsecase(this._EventRepository);
  @override
  Future<void> excecute(int input) async {
    return await _EventRepository.booking(input);
  }
}
