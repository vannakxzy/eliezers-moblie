import '../../../../data/data_sources/remotes/create_account_api_service.dart';
import '../../../home/domain/entities/subject_entity.dart';

import '../../../../app/base/response/base_data_response.dart';
import '../entities/avatar_entity.dart';
import '../entities/create_account_entity.dart';

abstract class CreateAccountRepository {
  Future<CreateAccountEntity> createAccount(
      {required CreateAccountInput createAccountInput});
  Future<List<SubjectEntity>> getAllSubject();
  Future<void> updateUserSubject({required List<int> subject});
  Future<DataResponse<List<AvartaEntity>>> getAvatar();
  Future<void> updateAvatar(String profile);
}
