import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/answer_api_service.dart';
import '../repository/answer_repository.dart';
import '../../../profile/domain/entities/answer_entity.dart';

@Injectable()
class UpdateAnswerUsecase
    extends BaseUseCase<UpdateAnswerInput, AnswertEntity> {
  final AnswerRepository _answerRepository;
  UpdateAnswerUsecase(this._answerRepository);
  @override
  Future<AnswertEntity> excecute(input) async {
    return await _answerRepository.updateAnswer(input);
  }
}
