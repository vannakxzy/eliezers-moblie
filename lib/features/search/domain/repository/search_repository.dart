import '../../../../data/data_sources/remotes/search_service.dart';
import '../../../home/domain/entities/question_respose_entity.dart';
import '../../../profile/domain/entities/answer_respose_entity.dart';
import '../entities/tag_respose_entity.dart';

import '../../../profile/domain/entities/profile_respose_entity.dart';
import '../entities/popular_search_entity.dart';

abstract class SearchRepository {
  Future<List<PopularSearchEntity>> getpopularSearch();
  Future<QuestionResposeEntity> getResutlSearch(
      {required String q, required int page});
  Future<ProfileResposeEntity> getUser(UserInput input);
  Future<AnswerResposeEntity> getAnswer({required String q, required int page});
  Future<TagResposeEntity> getTags({required QPageInput input});
  Future<QuestionResposeEntity> getQuestionByTag(GetQuestionByTagInput input);
}
