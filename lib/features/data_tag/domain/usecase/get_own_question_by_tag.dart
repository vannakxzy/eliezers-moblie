import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/data_tag_api_service.dart';
import '../repository/data_tag_repository.dart';

import '../../../home/domain/entities/question_respose_entity.dart';

@Injectable()
class GetOwnQuestionByTagUseCase
    extends BaseUseCase<TagIdInput, QuestionResposeEntity> {
  final DataTagRepository _dataTagRepository;
  GetOwnQuestionByTagUseCase(this._dataTagRepository);
  @override
  Future<QuestionResposeEntity> excecute(TagIdInput input) async {
    return await _dataTagRepository.getOwnQuestionByTag(input);
  }
}
