import '../../../../data/data_sources/remotes/profile_api_service.dart';
import '../../../home/domain/entities/question_respose_entity.dart';
import '../entities/answer_respose_entity.dart';
import '../../../setting/domain/entities/setting_entity.dart';

import '../entities/profile_entity.dart';
import '../entities/top_tag_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getOtherProfile({required int userId});
  Future<QuestionResposeEntity> getOtherQuestion(
      {required UserIdPageInput input});
  Future<AnswerResposeEntity> getOtherAnswer({required UserIdPageInput input});
  Future<List<TopTagEntity>> getOtherTopTag({required int userId});
  Future<SettingEntity> getOtherSetting({required int userId});
  Future<SettingEntity> getSetting();
  Future<ProfileEntity> getProfile();
  Future<List<TopTagEntity>> getTopTag();
  Future<QuestionResposeEntity> getQuestion(int page);
  Future<AnswerResposeEntity> getAnswer(int page);
}
