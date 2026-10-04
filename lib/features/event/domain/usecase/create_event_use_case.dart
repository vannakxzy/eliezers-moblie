import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../../../../data/data_sources/remotes/event_api_service.dart';
import '../repository/event_repository.dart';

@Injectable()
class CreateEventUsecase extends BaseUseCase<CreateEventInput, void> {
  final EventRepository _repository;
  CreateEventUsecase(this._repository);
  @override
  Future<void> excecute(CreateEventInput input) async {
    await _repository.createEvent(input);
    throw UnimplementedError();
  }
}
