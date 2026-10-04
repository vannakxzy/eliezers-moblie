import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/security_login_repository.dart';

@Injectable()
class DeleteActiveSessionUsecase extends BaseUseCase<int, void> {
  final SecurityLoginRepository _repository;
  DeleteActiveSessionUsecase(this._repository);
  @override
  Future<void> excecute(int input) async {
    return await _repository.deleteActiveSession(input);
  }
}
