import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/security_login_repository.dart';

@Injectable()
class DeleteUserUsecase extends BaseUseCase<void, void> {
  final SecurityLoginRepository _repository;
  DeleteUserUsecase(this._repository);

  @override
  Future<void> excecute(void input) async {
    return await _repository.deleteAccount();
  }
}
