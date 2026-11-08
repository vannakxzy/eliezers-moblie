import '../../../../data/data_sources/remotes/create_account_api_service.dart';

import '../entities/create_account_entity.dart';

abstract class CreateAccountRepository {
  Future<CreateAccountEntity> createAccount(
      {required CreateAccountInput createAccountInput});
  Future<void> updateUserSubject({required List<int> subject});
  Future<void> updateAvatar(String profile);
}
