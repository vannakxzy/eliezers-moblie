import 'package:injectable/injectable.dart';
import '../../../../data/data_sources/remotes/create_account_api_service.dart';
import '../../domain/entity/login_entity.dart';

import '../../domain/repository/login_repository.dart';
import '../data_sources/remote/login_api_service.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._loginApiService);

  final LoginApiService _loginApiService;

  @override
  Future<LoginResponseEntity> authWithGoogle(
      {required CreateAccountInput input}) async {
    return await _loginApiService.authWithGoogle(input: input);
  }

  @override
  Future<LoginResponseEntity> login({required LoginInput input}) async {
    return await _loginApiService.login(input: input);
  }

  @override
  Future<void> checkUser(CheckUserInput input) async {
    return await _loginApiService.checkUser(input);
  }
}
