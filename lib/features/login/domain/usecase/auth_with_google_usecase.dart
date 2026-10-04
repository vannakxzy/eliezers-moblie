import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/create_account_api_service.dart';
import '../entity/login_entity.dart';

import '../repository/login_repository.dart';

@Injectable()
class AuthWithGoogleUsecase
    extends BaseUseCase<CreateAccountInput, LoginResponseEntity> {
  final LoginRepository _loginRepository;
  AuthWithGoogleUsecase(this._loginRepository);
  @override
  Future<LoginResponseEntity> excecute(CreateAccountInput input) async {
    return await _loginRepository.authWithGoogle(input: input);
  }
}
