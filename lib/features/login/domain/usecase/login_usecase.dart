import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../entity/login_entity.dart';
import '../repository/login_repository.dart';

import '../../data/data_sources/remote/login_api_service.dart';

@Injectable()
class LoginUseCase implements BaseUseCase<LoginInput, LoginResponseEntity> {
  LoginUseCase(this._loginRepository);

  final LoginRepository _loginRepository;

  @override
  Future<LoginResponseEntity> excecute(LoginInput input) async {
    final output = await _loginRepository.login(input: input);
    return output;
  }
}
