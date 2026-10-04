import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/post_service.dart';
import '../entities/tag_entity.dart';
import '../repository/post_repository.dart';

@Injectable()
class GetTagUseCase implements BaseUseCase<TagInput, List<TagEntity>> {
  final PostRepository _postRepository;
  GetTagUseCase(this._postRepository);
  @override
  Future<List<TagEntity>> excecute(TagInput input) async {
    return await _postRepository.getTag(name: input.name, oldTag: input.oldTag);
  }
}
