import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/answer_api_service.dart';
import '../repository/answer_repository.dart';

import '../../../profile/domain/entities/answer_entity.dart';

@Injectable()
class CreateAnswerUseCase
    extends BaseUseCase<CreateAnswerInput, AnswertEntity> {
  final AnswerRepository _answerRepository;
  CreateAnswerUseCase(this._answerRepository);
  @override
  Future<AnswertEntity> excecute(CreateAnswerInput input) async {
    return await _answerRepository.createAnswer(input);
  }
}
