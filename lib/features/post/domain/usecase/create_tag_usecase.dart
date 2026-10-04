import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/tag_entity.dart';
import '../repository/post_repository.dart';

@Injectable()
class CreateTagUseCase extends BaseUseCase<String, TagEntity> {
  final PostRepository _postRepository;
  CreateTagUseCase(this._postRepository);
  @override
  Future<TagEntity> excecute(String input) async {
    return await _postRepository.createTag(name: input);
  }
}
