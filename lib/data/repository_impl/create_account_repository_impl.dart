import 'package:injectable/injectable.dart';
import '../data_sources/remotes/create_account_api_service.dart';


import '../../features/create_account/domain/entities/create_account_entity.dart';
import '../../features/create_account/domain/repository/create_account_repository.dart';

@LazySingleton(as: CreateAccountRepository)
class CreateAccountRepositoryImpl implements CreateAccountRepository {
  final CreateAccountApiService _accountApiService;
  CreateAccountRepositoryImpl(this._accountApiService);

  @override
  Future<CreateAccountEntity> createAccount(
      {required CreateAccountInput createAccountInput}) async {
    return await _accountApiService.createAccount(createAccountInput);
  }

 

  @override
  Future<void> updateUserSubject({required List<int> subject}) async {
    await _accountApiService.updateUserSubject({"subject": subject});
  }


  @override
  Future<void> updateAvatar(String profile) async {
    return await _accountApiService.updateAvatar(profile: profile);
  }
}
