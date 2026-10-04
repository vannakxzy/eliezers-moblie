import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../home/domain/entities/question_respose_entity.dart';

import '../repository/profile_repository.dart';

@Injectable()
class GetQuestionByUserUseCase extends BaseUseCase<int, QuestionResposeEntity> {
  final ProfileRepository _profileRepository;
  GetQuestionByUserUseCase(this._profileRepository);
  @override
  Future<QuestionResposeEntity> excecute(int input) async {
    return await _profileRepository.getQuestion(input);
  }
}
