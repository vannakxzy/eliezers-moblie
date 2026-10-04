import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/security_login_repository.dart';

import '../../../login/domain/entity/login_entity.dart';

@Injectable()
class ChangePasswordUsecase
    implements BaseUseCase<String, LoginResponseEntity> {
  final SecurityLoginRepository _repository;
  ChangePasswordUsecase(this._repository);
  @override
  Future<LoginResponseEntity> excecute(String input) async {
    return await _repository.changePassword(input);
  }
}
