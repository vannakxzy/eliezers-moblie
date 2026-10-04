import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/search_service.dart';
import '../../../profile/domain/entities/answer_respose_entity.dart';
import '../repository/search_repository.dart';

@Injectable()
class GetSearchAnswerUsecase
    extends BaseUseCase<QPageInput, AnswerResposeEntity> {
  final SearchRepository _repository;
  GetSearchAnswerUsecase(this._repository);

  @override
  Future<AnswerResposeEntity> excecute(QPageInput input) async {
    return await _repository.getAnswer(page: input.page, q: input.q);
  }
}
