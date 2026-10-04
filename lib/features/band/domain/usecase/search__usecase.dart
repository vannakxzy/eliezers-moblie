import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../entities/band_respose_entity.dart';
import '../repository/band_repository.dart';

@Injectable()
class SearchbandUsecase implements BaseUseCase<SearchInput, BandResposeEntity> {
  final BandRepository _repository;
  SearchbandUsecase(this._repository);
  @override
  Future<BandResposeEntity> excecute(input) async {
    return await _repository.searchband(input);
  }
}
