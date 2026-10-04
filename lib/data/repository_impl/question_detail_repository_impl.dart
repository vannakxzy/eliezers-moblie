import 'package:injectable/injectable.dart';
import '../data_sources/remotes/question_detail_service.dart';
import '../models/question_model.dart';
import '../../features/home/domain/entities/question_entity.dart';
import '../../features/question_detail/domain/repository/question_detail_repository.dart';

@Injectable(as: QuestionDetailRepository)
class QuestionDetailRepositoryImpl extends QuestionDetailRepository {
  final QuestionDetailService _questionDetailService;
  QuestionDetailRepositoryImpl(this._questionDetailService);

  @override
  Future<void> likeAnswer({required int answerId}) async {
    return await _questionDetailService.likeAnswer(answerId: answerId);
  }

  @override
  Future<void> unLikeAnswer({required int answerId}) async {
    return await _questionDetailService.unLikeAnswer(answerId: answerId);
  }

  @override
  Future<void> deleteQuestion(int id) async {
    return await _questionDetailService.deleteQuestion(quesitonId: id);
  }

  @override
  Future<void> updateQuestion(UpdateQuestionInput input) async {
    return await _questionDetailService.updateQuestion(input);
  }

  @override
  Future<QuestionEntity> getQuestionById(int id) async {
    final question =
        await _questionDetailService.getQuestionById(questionId: id);
    return question.toEntity();
  }

  @override
  Future<void> correctAnswer({required int answerId}) async {
    return await _questionDetailService.correctAnswer(answerId: answerId);
  }
}
