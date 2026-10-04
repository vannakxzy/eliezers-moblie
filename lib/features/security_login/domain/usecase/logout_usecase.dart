import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/security_login_repository.dart';

@Injectable()
class LogoutUsecase extends BaseUseCase<void, void> {
  @override
  LogoutUsecase(this._securityLoginRepository);
  final SecurityLoginRepository _securityLoginRepository;

  @override
  Future<void> excecute(void input) async {
    return await _securityLoginRepository.logout();
  }
}
