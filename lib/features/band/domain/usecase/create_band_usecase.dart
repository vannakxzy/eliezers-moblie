import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../entities/band_entity.dart';
import '../repository/band_repository.dart';

@Injectable()
class CreatebandUsecase implements BaseUseCase<bandInput, BandEntity> {
  final BandRepository _repository;
  CreatebandUsecase(this._repository);
  @override
  Future<BandEntity> excecute(input) async {
    return await _repository.createband(input);
  }
}
