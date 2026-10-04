import 'package:injectable/injectable.dart';
import '../data_sources/remotes/security_login_api_service.dart';
import '../models/security_login/active_session_model.dart';
import '../models/security_login/block_respose_model.dart';
import '../models/security_login/hide_respose_model.dart';
import '../../features/security_login/domain/entities/active_session_entity.dart';
import '../../features/security_login/domain/entities/block_respnose_entity.dart';
import '../../features/security_login/domain/entities/hide_respose_entity.dart';

import '../../features/login/domain/entity/login_entity.dart';
import '../../features/security_login/domain/repository/security_login_repository.dart';

@LazySingleton(as: SecurityLoginRepository)
class SecurityLoginRepositoryImpl implements SecurityLoginRepository {
  final SecurityLoginApiService _securityLoginApiService;
  SecurityLoginRepositoryImpl(this._securityLoginApiService);

  @override
  Future<void> unBlock(int id) async {
    return await _securityLoginApiService.unBlock(id);
  }

  @override
  Future<void> unHide(int id) async {
    return await _securityLoginApiService.unHide(id);
  }

  @override
  Future<void> createBlock(int userId) async {
    return await _securityLoginApiService.createBlock(userId);
  }

  @override
  Future<void> createHide(int questionId) async {
    return await _securityLoginApiService
        .createHide(QuestionIdInput(question_id: questionId));
  }

  @override
  Future<LoginResponseEntity> changePassword(String newPassword) async {
    return await _securityLoginApiService.changePassword(newPassword);
  }

  @override
  Future<void> unHideByQuestionId(int id) async {
    return await _securityLoginApiService.unHideByQuestionId(id);
  }

  @override
  Future<HideResposeEntity> getHide(int page) async {
    final data = await _securityLoginApiService.getHide(page: page);
    return data.toEntity();
  }

  @override
  Future<BlockRespnoseEntity> getBlock(int page) async {
    final block = await _securityLoginApiService.getBlock(page: page);
    return block.toEntity();
  }

  @override
  Future<List<ActiveSessionEntity>> getActiveSession() async {
    final activeSession = await _securityLoginApiService.getActiveSession();
    return activeSession.toListEntity();
  }

  @override
  Future<void> deleteAccount() async {
    return await _securityLoginApiService.deleteAccount();
  }

  @override
  Future<void> deleteActiveSession(int id) async {
    return await _securityLoginApiService.deleteActiveSession(id: id);
  }

  @override
  Future<void> deleteOtherSession() async {
    return await _securityLoginApiService.deleteOtherSession();
  }

  @override
  Future<void> logout() async {
    return await _securityLoginApiService.logout();
  }
}
