import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/profile_api_service.dart';
import '../entities/answer_respose_entity.dart';

import '../repository/profile_repository.dart';

@Injectable()
class GetOtherAnswerUseCase
    extends BaseUseCase<UserIdPageInput, AnswerResposeEntity> {
  final ProfileRepository _ProfileRepository;
  GetOtherAnswerUseCase(this._ProfileRepository);
  @override
  Future<AnswerResposeEntity> excecute(UserIdPageInput input) async {
    return await _ProfileRepository.getOtherAnswer(input: input);
  }
}
