import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/question_detail_repository.dart';

import '../../../home/domain/entities/question_entity.dart';

@Injectable()
class GetQuestionByIdUseCase extends BaseUseCase<int, QuestionEntity> {
  final QuestionDetailRepository _questionDetailRepository;
  GetQuestionByIdUseCase(this._questionDetailRepository);
  @override
  Future<QuestionEntity> excecute(int input) async {
    return await _questionDetailRepository.getQuestionById(input);
  }
}
