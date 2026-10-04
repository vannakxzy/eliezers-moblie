import 'package:injectable/injectable.dart';
import '../data_sources/remotes/answer_api_service.dart';
import '../models/profile/answer_model.dart';
import '../models/profile/answer_respose_model.dart';
import '../../features/profile/domain/entities/answer_respose_entity.dart';

import '../../features/answer/domain/repository/answer_repository.dart';
import '../../features/profile/domain/entities/answer_entity.dart';

@LazySingleton(as: AnswerRepository)
class AnswerRepositoryImpl implements AnswerRepository {
  final AnswerApiService _service;
  AnswerRepositoryImpl(this._service);

  @override
  Future<AnswertEntity> createAnswer(CreateAnswerInput input) async {
    final answer = await _service.createAnswer(input: input);
    return answer.toEntity();
  }

  @override
  Future<void> deleteAnswer(int id) async {
    return await _service.deleteAnswer(id: id);
  }

  @override
  Future<AnswertEntity> updateAnswer(UpdateAnswerInput input) async {
    final answer = await _service.updateAnswer(answerInput: input);
    return answer.toEntity();
  }

  @override
  Future<void> likeAnswer(int id) async {
    return await _service.likeAnswer(answerId: id);
  }

  @override
  Future<AnswerResposeEntity> getAnswer(
      {required int questionId, required int page}) async {
    final answer = await _service.getAnswer(
        input: GetAnswerInput(question_id: questionId, page: page));
    return answer.toEntity();
  }
}
