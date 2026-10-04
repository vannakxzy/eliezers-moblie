import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/question_respose_entity.dart';
import '../repository/home_repository.dart';

import '../../../../data/data_sources/remotes/home_api_service.dart';

@Injectable()
class GetAllQuestionUsecase
    extends BaseUseCase<GetQuestionInput, QuestionResposeEntity> {
  GetAllQuestionUsecase(this._homeRepository);
  final HomeRepository _homeRepository;
  @override
  Future<QuestionResposeEntity> excecute(GetQuestionInput input) async {
    return await _homeRepository.getAllQuestions(input);
  }
}
