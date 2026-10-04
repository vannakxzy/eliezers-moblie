import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../entities/band_respose_entity.dart';
import '../repository/band_repository.dart';

@Injectable()
class GetbandInUserUsecase
    implements BaseUseCase<GetbandInUserInput, BandResposeEntity> {
  final BandRepository _repository;
  GetbandInUserUsecase(this._repository);
  @override
  Future<BandResposeEntity> excecute(input) async {
    return await _repository.getbandInUser(input);
  }
}
