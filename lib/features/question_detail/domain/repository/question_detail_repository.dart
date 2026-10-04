import '../../../home/domain/entities/question_entity.dart';

import '../../../../data/data_sources/remotes/question_detail_service.dart';

abstract class QuestionDetailRepository {
  Future<void> correctAnswer({required int answerId});
  Future<void> likeAnswer({required int answerId});
  Future<void> unLikeAnswer({required int answerId});
  Future<void> deleteQuestion(int id);
  Future<QuestionEntity> getQuestionById(int id);
  Future<void> updateQuestion(UpdateQuestionInput input);
}
