import 'package:injectable/injectable.dart';
import '../data_sources/remotes/forgot_password_api_service.dart';
import '../../features/login/domain/entity/login_entity.dart';

import '../../features/forgot_password/domain/repository/forgot_password_repository.dart';

@LazySingleton(as: ForgotPasswordRepository)
class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordApiService _forgotPasswordApiService;
  ForgotPasswordRepositoryImpl(this._forgotPasswordApiService);
  @override
  Future<LoginResponseEntity> createNewPassword(
      {required CreateNewPassWordInput createNewPassWordInput}) async {
    return await _forgotPasswordApiService.createNewPassword(
        createNewPassWordInput: createNewPassWordInput);
  }
}
