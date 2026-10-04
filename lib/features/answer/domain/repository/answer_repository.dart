import '../../../../data/data_sources/remotes/answer_api_service.dart';
import '../../../profile/domain/entities/answer_respose_entity.dart';

import '../../../profile/domain/entities/answer_entity.dart';

abstract class AnswerRepository {
  Future<AnswertEntity> createAnswer(CreateAnswerInput input);
  Future<AnswerResposeEntity> getAnswer(
      {required int questionId, required int page});
  Future<void> deleteAnswer(int id);
  Future<void> likeAnswer(int id);
  Future<AnswertEntity> updateAnswer(UpdateAnswerInput input);
}
