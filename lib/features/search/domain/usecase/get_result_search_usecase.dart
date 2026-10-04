import 'package:injectable/injectable.dart';
import '../../../../data/models/homes/question_respose_model.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/search_service.dart';
import '../../../home/domain/entities/question_respose_entity.dart';

@Injectable()
class GetResultSearchUseCase
    extends BaseUseCase<QPageInput, QuestionResposeEntity> {
  GetResultSearchUseCase(this._searchService);
  final SearchService _searchService;
  @override
  Future<QuestionResposeEntity> excecute(QPageInput input) async {
    final quesiton = await _searchService.getResultSearch(input: input);
    return quesiton.toEntity();
  }
}
