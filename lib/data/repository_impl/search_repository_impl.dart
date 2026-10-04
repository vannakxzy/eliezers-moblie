import 'package:injectable/injectable.dart';
import '../models/homes/question_respose_model.dart';
import '../models/profile/answer_respose_model.dart';
import '../data_sources/remotes/search_service.dart';
import '../models/profile/profile_respose_model.dart';
import '../models/search/tag_respose_model.dart';
import '../../features/profile/domain/entities/answer_respose_entity.dart';
import '../../features/profile/domain/entities/profile_respose_entity.dart';
import '../../features/search/domain/entities/popular_search_entity.dart';
import '../../features/search/domain/entities/tag_respose_entity.dart';
import '../../features/search/domain/repository/search_repository.dart';

import '../../features/home/domain/entities/question_respose_entity.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl(this._searchService);
  final SearchService _searchService;

  @override
  Future<List<PopularSearchEntity>> getpopularSearch() async {
    return await _searchService.getpopularSearch();
  }

  @override
  Future<AnswerResposeEntity> getAnswer(
      {required String q, required int page}) async {
    final answer = await _searchService.getSearchAnswer(
        input: QPageInput(q: q, page: page));
    return answer.toEntity();
  }

  @override
  Future<QuestionResposeEntity> getResutlSearch(
      {required String q, required int page}) async {
    final question = await _searchService.getResultSearch(
        input: QPageInput(q: q, page: page));
    return question.toEntity();
  }

  @override
  Future<ProfileResposeEntity> getUser(UserInput input) async {
    final user = await _searchService.getSearchUser(input: input);
    return user.toEntity();
  }

  @override
  Future<TagResposeEntity> getTags({required QPageInput input}) async {
    final tags = await _searchService.getTag(input: input);
    return tags.toEntity();
  }

  @override
  Future<QuestionResposeEntity> getQuestionByTag(
      GetQuestionByTagInput input) async {
    final question = await _searchService.getQuestionByTag(input: input);
    return question.toEntity();
  }
}
