import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/data_tag_api_service.dart';
import '../repository/data_tag_repository.dart';
import '../../../home/domain/entities/question_respose_entity.dart';

@Injectable()
class GetQuesitonByUserByTagUseCase
    extends BaseUseCase<UserIdTagIdInput, QuestionResposeEntity> {
  final DataTagRepository _dataTagRepository;
  GetQuesitonByUserByTagUseCase(this._dataTagRepository);
  @override
  Future<QuestionResposeEntity> excecute(UserIdTagIdInput input) async {
    return await _dataTagRepository.getOtherQuestionByTag(input);
  }
}
