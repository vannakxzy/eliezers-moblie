import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/post_service.dart';
import '../repository/post_repository.dart';

@Injectable()
class CreateQuestionUseCase extends BaseUseCase<CreateQuestionInput, void> {
  CreateQuestionUseCase(this._postRepository);
  final PostRepository _postRepository;
  @override
  Future excecute(input) async {
    return await _postRepository.createQuestion(CreateQuestionInput: input);
  }
}
