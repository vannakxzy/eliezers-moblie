import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/forgot_password_api_service.dart';
import '../repository/forgot_password_repository.dart';
import '../../../login/domain/entity/login_entity.dart';

@Injectable()
class CreateNewPasswordUsercase
    extends BaseUseCase<CreateNewPassWordInput, LoginResponseEntity> {
  final ForgotPasswordRepository _forgotPasswordRepository;
  CreateNewPasswordUsercase(this._forgotPasswordRepository);
  @override
  Future<LoginResponseEntity> excecute(input) async {
    return await _forgotPasswordRepository.createNewPassword(
      createNewPassWordInput: input,
    );
  }
}
