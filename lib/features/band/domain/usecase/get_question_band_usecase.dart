import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../home/domain/entities/question_respose_entity.dart';
import '../repository/band_repository.dart';

@Injectable()
class GetQuestionbandUsecase
    implements BaseUseCase<bandIdPageInput, QuestionResposeEntity> {
  final BandRepository _repository;
  GetQuestionbandUsecase(this._repository);
  @override
  Future<QuestionResposeEntity> excecute(input) async {
    return await _repository.getQuestionInband(input);
  }
}
