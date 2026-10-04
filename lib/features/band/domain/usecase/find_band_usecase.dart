import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/band_entity.dart';
import '../repository/band_repository.dart';

@Injectable()
class FindbandUsecase implements BaseUseCase<int, BandEntity> {
  final BandRepository _repository;
  FindbandUsecase(this._repository);
  @override
  Future<BandEntity> excecute(input) async {
    return await _repository.findband(input);
  }
}
