import 'package:injectable/injectable.dart';
import '../models/homes/question_respose_model.dart';
import '../models/profile/answer_respose_model.dart';
import '../models/profile/profile_model.dart';
import '../models/create-account/settings/setting_model.dart';
import '../../features/home/domain/entities/question_respose_entity.dart';
import '../../features/profile/domain/entities/answer_respose_entity.dart';
import '../../features/profile/domain/entities/profile_entity.dart';
import '../../features/profile/domain/entities/top_tag_entity.dart';
import '../../features/setting/domain/entities/setting_entity.dart';

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
  Future<SettingEntity> getSetting() async {
    final setting = await _service.getSetting();
    return setting.toEntity();
  }

  @override
  Future<List<TopTagEntity>> getOtherTopTag({required int userId}) async {
    return await _service.getOtherTopTag(userId);
  }

  @override
  Future<ProfileEntity> getProfile() async {
    final answer = await _service.getProfile();
    return answer.toEntity();
  }

  @override
  Future<List<TopTagEntity>> getTopTag() async {
    final tag = await _service.getTopTag();
    return tag;
  }

  @override
  Future<AnswerResposeEntity> getAnswer(int page) async {
    final answer = await _service.getAnswer(page);
    return answer.toEntity();
  }

  @override
  Future<AnswerResposeEntity> getOtherAnswer(
      {required UserIdPageInput input}) async {
    final answer = await _service.getOtherAnswer(input: input);
    return answer.toEntity();
  }

  @override
  Future<QuestionResposeEntity> getOtherQuestion(
      {required UserIdPageInput input}) async {
    final question = await _service.getOtherQuestion(input: input);
    return question.toEntity();
  }

  @override
  Future<QuestionResposeEntity> getQuestion(int page) async {
    final question = await _service.getQuestion(page);
    return question.toEntity();
  }

  @override
  Future<SettingEntity> getOtherSetting({required int userId}) async {
    final setting = await _service.getOtherSetting(userId);
    return setting.toEntity();
  }
}
