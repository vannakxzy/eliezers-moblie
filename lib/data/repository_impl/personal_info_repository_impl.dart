import 'package:injectable/injectable.dart';
import '../data_sources/remotes/personal_info_api_service.dart';
import '../models/profile/profile_model.dart';
import '../../features/profile/domain/entities/profile_entity.dart';

import '../../features/personal_info/domain/repository/personal_info_repository.dart';

@LazySingleton(as: PersonalInfoRepository)
class PersonalInfoRepositoryImpl implements PersonalInfoRepository {
  final PersonalInfoApiService _personalInfoApiService;
  PersonalInfoRepositoryImpl(this._personalInfoApiService);
  @override
  Future<ProfileEntity> updatePersonalInfo(
      {required UpdatePersonalInfoInput updatePersonalInfoInput}) async {
    final profile = await _personalInfoApiService.updatePersonalInfo(
      updatePersonalInfoInput: updatePersonalInfoInput,
    );
    return profile.toEntity();
  }

  @override
  Future<int> checkEmail({required String email}) async {
    return await _personalInfoApiService.checkEmail(email: email);
  }

  @override
  Future<int> checkUserName({required String userName}) async {
    return await _personalInfoApiService.checkUserName(userName: userName);
  }

  @override
  Future<void> updateProfile({required String profile}) async {
    return await _personalInfoApiService.updateProfile(profile: profile);
  }
}
