
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getOtherProfile({required int userId});
  Future<ProfileEntity> getProfile();
}
