import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/question_entity.dart';
import '../repository/home_repository.dart';

@Injectable()
class GetQuestionBySubjectUserCase
    extends BaseUseCase<int, List<QuestionEntity>> {
  final HomeRepository _homeRepository;
  GetQuestionBySubjectUserCase(this._homeRepository);
  @override
  Future<List<QuestionEntity>> excecute(int input) async {
    return await _homeRepository.getQuestionBySubject(id: input);
  }
}
