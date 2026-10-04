import '../../../../data/data_sources/remotes/personal_info_api_service.dart';
import '../../../profile/domain/entities/profile_entity.dart';

abstract class PersonalInfoRepository {
  Future<ProfileEntity> updatePersonalInfo(
      {required UpdatePersonalInfoInput updatePersonalInfoInput});
  Future<int> checkEmail({required String email});
  Future<int> checkUserName({required String userName});
  Future<void> updateProfile({required String profile});
}
