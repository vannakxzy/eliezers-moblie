import '../../data/data_sources/remote/login_api_service.dart';
import '../entity/login_entity.dart';

import '../../../../data/data_sources/remotes/create_account_api_service.dart';

abstract class LoginRepository {
  Future<LoginResponseEntity> login({required LoginInput input});
  Future<LoginResponseEntity> authWithGoogle(
      {required CreateAccountInput input});
  Future<void> checkUser(CheckUserInput input);
}
