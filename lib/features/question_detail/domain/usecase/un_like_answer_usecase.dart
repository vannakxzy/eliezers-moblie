import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/question_detail_repository.dart';

@Injectable()
class UnLikeAnswerUsecase extends BaseUseCase<int, void> {
  final QuestionDetailRepository _questionDetailRepository;
  UnLikeAnswerUsecase(this._questionDetailRepository);
  @override
  Future<void> excecute(int input) async {
    return await _questionDetailRepository.unLikeAnswer(answerId: input);
  }
}
