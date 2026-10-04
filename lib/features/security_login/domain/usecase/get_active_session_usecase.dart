import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/active_session_entity.dart';
import '../repository/security_login_repository.dart';

@Injectable()
class GetActiveSessionUsecase
    extends BaseUseCase<void, List<ActiveSessionEntity>> {
  final SecurityLoginRepository _repository;
  GetActiveSessionUsecase(this._repository);
  @override
  Future<List<ActiveSessionEntity>> excecute(void input) async {
    return await _repository.getActiveSession();
  }
}
