import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/security_login_repository.dart';

@Injectable()
class UnBlockUseCase extends BaseUseCase<int, void> {
  @override
  UnBlockUseCase(this._securityLoginRepository);
  final SecurityLoginRepository _securityLoginRepository;
  @override
  Future<void> excecute(int input) async {
    return await _securityLoginRepository.unBlock(input);
  }
}
