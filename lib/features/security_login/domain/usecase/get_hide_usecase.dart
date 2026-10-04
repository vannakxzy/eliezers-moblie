import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/security_login_repository.dart';

import '../entities/hide_respose_entity.dart';

@Injectable()
class GetHideUseCase extends BaseUseCase<int, HideResposeEntity> {
  @override
  GetHideUseCase(this._securityLoginRepository);
  final SecurityLoginRepository _securityLoginRepository;

  @override
  Future<HideResposeEntity> excecute(int input) async {
    final data = await _securityLoginRepository.getHide(input);
    return data;
  }
}
