import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/profile_api_service.dart';
import '../../../home/domain/entities/question_respose_entity.dart';

import '../repository/profile_repository.dart';

@Injectable()
class GetOtherQuestionUseCase
    extends BaseUseCase<UserIdPageInput, QuestionResposeEntity> {
  final ProfileRepository _ProfileRepository;
  GetOtherQuestionUseCase(this._ProfileRepository);
  @override
  Future<QuestionResposeEntity> excecute(UserIdPageInput input) async {
    return await _ProfileRepository.getOtherQuestion(input: input);
  }
}
