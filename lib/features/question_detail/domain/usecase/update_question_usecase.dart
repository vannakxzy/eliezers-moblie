import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/question_detail_repository.dart';

import '../../../../data/data_sources/remotes/question_detail_service.dart';

@Injectable()
class UpdateQuestionUsecase extends BaseUseCase<UpdateQuestionInput, void> {
  final QuestionDetailRepository _questionDetailRepository;
  UpdateQuestionUsecase(this._questionDetailRepository);
  @override
  Future<void> excecute(UpdateQuestionInput input) async {
    return await _questionDetailRepository.updateQuestion(input);
  }
}
