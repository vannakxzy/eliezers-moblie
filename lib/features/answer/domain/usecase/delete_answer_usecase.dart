import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/answer_repository.dart';

@Injectable()
class DeleteAnswerUsecase extends BaseUseCase<int, void> {
  final AnswerRepository _answerRepository;
  DeleteAnswerUsecase(this._answerRepository);
  @override
  Future<void> excecute(int input) async {
    return await _answerRepository.deleteAnswer(input);
  }
}
