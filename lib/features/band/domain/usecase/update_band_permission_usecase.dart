import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../repository/band_repository.dart';

@Injectable()
class UpdatebandPermissionUsecase
    implements BaseUseCase<bandPermissionInput, void> {
  final BandRepository _repository;
  UpdatebandPermissionUsecase(this._repository);
  @override
  Future<void> excecute(input) async {
    await _repository.updateCommunitPermission(input);
  }
}
