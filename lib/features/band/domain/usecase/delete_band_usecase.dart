import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/band_repository.dart';

@Injectable()
class DeletebandUsecase implements BaseUseCase<int, void> {
  final BandRepository _repository;
  DeletebandUsecase(this._repository);
  @override
  Future<void> excecute(input) async {
    return await _repository.deleteband(input);
  }
}
