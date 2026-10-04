import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/search_service.dart';
import '../entities/tag_respose_entity.dart';

import '../repository/search_repository.dart';

@Injectable()
class SearchTagCountUsercase extends BaseUseCase<QPageInput, TagResposeEntity> {
  final SearchRepository _repository;
  SearchTagCountUsercase(this._repository);

  @override
  Future<TagResposeEntity> excecute(QPageInput input) async {
    final tag = await _repository.getTags(input: input);
    return tag;
  }
}
