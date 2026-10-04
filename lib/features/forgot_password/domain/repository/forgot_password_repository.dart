import '../../../login/domain/entity/login_entity.dart';

import '../../../../data/data_sources/remotes/forgot_password_api_service.dart';

abstract class ForgotPasswordRepository {
  Future<LoginResponseEntity> createNewPassword(
      {required CreateNewPassWordInput createNewPassWordInput});
}
