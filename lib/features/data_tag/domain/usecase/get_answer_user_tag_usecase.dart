import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/data_tag_api_service.dart';
import '../repository/data_tag_repository.dart';
import '../../../profile/domain/entities/answer_respose_entity.dart';

@Injectable()
class GetAnserByUserByTagUseCase
    extends BaseUseCase<UserIdTagIdInput, AnswerResposeEntity> {
  final DataTagRepository _dataTagRepository;
  GetAnserByUserByTagUseCase(this._dataTagRepository);
  @override
  Future<AnswerResposeEntity> excecute(UserIdTagIdInput input) async {
    return await _dataTagRepository.getOtherAnswerByTag(input);
  }
}
