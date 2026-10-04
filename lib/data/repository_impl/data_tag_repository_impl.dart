import 'package:injectable/injectable.dart';
import '../models/homes/question_respose_model.dart';
import '../models/profile/answer_respose_model.dart';
import '../../features/home/domain/entities/question_respose_entity.dart';
import '../../features/profile/domain/entities/answer_respose_entity.dart';

import '../../features/data_tag/domain/repository/data_tag_repository.dart';
import '../data_sources/remotes/data_tag_api_service.dart';

@LazySingleton(as: DataTagRepository)
class DataTagRepositoryImpl implements DataTagRepository {
  final DataTagApiService _apiService;
  DataTagRepositoryImpl(this._apiService);

  @override
  Future<AnswerResposeEntity> getOtherAnswerByTag(
      UserIdTagIdInput input) async {
    final answer = await _apiService.getOtherAnswerByTag(input: input);
    return answer.toEntity();
  }

  @override
  Future<QuestionResposeEntity> getOtherQuestionByTag(
      UserIdTagIdInput input) async {
    final question = await _apiService.getOtherQuestionByTag(input: input);
    return question.toEntity();
  }

  @override
  Future<AnswerResposeEntity> getOwnAnswerByTag(TagIdInput input) async {
    final answer = await _apiService.getOwnAnswerByTag(input: input);
    return answer.toEntity();
  }

  @override
  Future<QuestionResposeEntity> getOwnQuestionByTag(TagIdInput input) async {
    final question = await _apiService.getOwnQuestionByTag(input: input);
    return question.toEntity();
  }
}
