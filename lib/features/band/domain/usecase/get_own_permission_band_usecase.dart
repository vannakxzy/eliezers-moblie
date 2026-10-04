import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/band_repository.dart';

@Injectable()
class GetOwnPermissionbandUsecase implements BaseUseCase<int, void> {
  final BandRepository _repository;
  GetOwnPermissionbandUsecase(this._repository);
  @override
  Future<void> excecute(int input) async {
    await _repository.getOwnPermissionband(input);
  }
}
