import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/answer_api_service.dart';
import '../repository/answer_repository.dart';
import '../../../profile/domain/entities/answer_respose_entity.dart';

@Injectable()
class GetAnswerInQuestionUseCase
    extends BaseUseCase<GetAnswerInput, AnswerResposeEntity> {
  final AnswerRepository _answerRepository;
  GetAnswerInQuestionUseCase(this._answerRepository);
  @override
  Future<AnswerResposeEntity> excecute(input) async {
    return await _answerRepository.getAnswer(
        page: input.page, questionId: input.question_id);
  }
}
