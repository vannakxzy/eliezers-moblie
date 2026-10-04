// ignore_for_file: file_names

import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/security_login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UnHideByQuestionidUseCase extends BaseUseCase<int, void> {
  @override
  UnHideByQuestionidUseCase(this._securityLoginRepository);
  final SecurityLoginRepository _securityLoginRepository;
  @override
  Future<void> excecute(int input) async {
    return await _securityLoginRepository.unHideByQuestionId(input);
  }
}
