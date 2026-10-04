import '../entities/block_respnose_entity.dart';

import '../../../login/domain/entity/login_entity.dart';
import '../entities/active_session_entity.dart';
import '../entities/hide_respose_entity.dart';

abstract class SecurityLoginRepository {
  Future<void> createBlock(int userId);
  Future<BlockRespnoseEntity> getBlock(int page);
  Future<void> unBlock(int id);
  Future<void> createHide(int questionId);
  Future<HideResposeEntity> getHide(int page);
  Future<void> unHide(int id);
  Future<void> unHideByQuestionId(int id);
  Future<LoginResponseEntity> changePassword(String newPassword);
  Future<List<ActiveSessionEntity>> getActiveSession();
  Future<void> deleteAccount();
  Future<void> deleteActiveSession(int id);
  Future<void> deleteOtherSession();
  Future<void> logout();
}
