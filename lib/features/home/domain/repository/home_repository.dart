import '../entities/question_entity.dart';
import '../entities/question_respose_entity.dart';
import '../entities/subject_entity.dart';

import '../../../../data/data_sources/remotes/home_api_service.dart';

abstract class HomeRepository {
  Future<QuestionResposeEntity> getAllQuestions(GetQuestionInput input);
  Future<int> countResult(GetQuestionInput input);
  Future<List<SubjectEntity>> GetSubjectEvent();
  Future<List<QuestionEntity>> getQuestionBySubject({required int id});
  Future<void> likeQuestion(int id);
  Future<void> unLikeQuestion(int id);
  Future<void> postDeviceToken({required String deviceToken});
}
