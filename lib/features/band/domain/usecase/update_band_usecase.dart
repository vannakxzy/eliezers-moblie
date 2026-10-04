import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../repository/band_repository.dart';

@Injectable()
class UpdatebandUsecase implements BaseUseCase<bandInput, void> {
  final BandRepository _repository;
  UpdatebandUsecase(this._repository);
  @override
  Future<void> excecute(input) async {
    await _repository.updateband(input);
  }
}
