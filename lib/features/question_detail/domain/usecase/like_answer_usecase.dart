import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/question_detail_repository.dart';

@Injectable()
class LikeAnswerUseCase extends BaseUseCase<int, void> {
  final QuestionDetailRepository _questionDetailRepository;
  LikeAnswerUseCase(this._questionDetailRepository);
  @override
  Future<void> excecute(int input) async {
    return await _questionDetailRepository.likeAnswer(answerId: input);
  }
}
