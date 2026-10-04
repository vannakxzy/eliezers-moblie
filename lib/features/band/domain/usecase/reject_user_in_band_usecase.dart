import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../repository/band_repository.dart';

@Injectable()
class RejectUserInbandUsecase implements BaseUseCase<BandIdUserIdInput, void> {
  final BandRepository _repository;

  RejectUserInbandUsecase(this._repository);

  @override
  Future<void> excecute(BandIdUserIdInput input) async {
    await _repository.rejectUserInband(input);
  }
}
