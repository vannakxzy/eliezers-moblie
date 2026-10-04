import '../../../../data/data_sources/remotes/data_tag_api_service.dart';
import '../../../home/domain/entities/question_respose_entity.dart';
import '../../../profile/domain/entities/answer_respose_entity.dart';

abstract class DataTagRepository {
  Future<AnswerResposeEntity> getOtherAnswerByTag(UserIdTagIdInput input);
  Future<QuestionResposeEntity> getOtherQuestionByTag(UserIdTagIdInput input);
  Future<AnswerResposeEntity> getOwnAnswerByTag(TagIdInput input);
  Future<QuestionResposeEntity> getOwnQuestionByTag(TagIdInput input);
}
