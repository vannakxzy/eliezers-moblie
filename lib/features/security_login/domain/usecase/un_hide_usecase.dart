import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/security_login_repository.dart';

@Injectable()
class UnHideUsecase extends BaseUseCase<int, void> {
  @override
  UnHideUsecase(this._securityLoginRepository);
  final SecurityLoginRepository _securityLoginRepository;
  @override
  Future<void> excecute(int input) async {
    return await _securityLoginRepository.unHide(input);
  }
}
