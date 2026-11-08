import 'package:injectable/injectable.dart';
import '../models/profile/profile_model.dart';
import '../../features/profile/domain/entities/profile_entity.dart';

import '../../features/profile/domain/repository/profile_repository.dart';
import '../data_sources/remotes/profile_api_service.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _service;
  ProfileRepositoryImpl(this._service);
  @override
  @override
  Future<ProfileEntity> getOtherProfile({required int userId}) async {
    final profile = await _service.getOtherProfile(userId);
    return profile.toEntity();
  }
  @override
  Future<ProfileEntity> getProfile() async {
    final answer = await _service.getProfile();
    return answer.toEntity();
  } 
}
