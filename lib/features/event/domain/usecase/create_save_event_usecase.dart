import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../repository/event_repository.dart';

@Injectable()
class CreateSaveEventUsecase extends BaseUseCase<int, void> {
  final EventRepository _repository;
  CreateSaveEventUsecase(this._repository);
  @override
  Future<void> excecute(int input) async {
    await _repository.saveEvent(input);
  }
}
