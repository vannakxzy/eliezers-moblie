import 'package:injectable/injectable.dart';
import '../data_sources/remotes/post_service.dart';
import '../../features/post/domain/entities/tag_entity.dart';
import '../../features/post/domain/repository/post_repository.dart';

import '../models/post_question/tag_model.dart';

@Injectable(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  PostRepositoryImpl(this._postService);
  final PostService _postService;

  @override
  Future<List<TagEntity>> getTag(
      {required String name, required List<int> oldTag}) async {
    final responsse = await _postService.getTag(
      tagInput: TagInput(
        oldTag: oldTag,
        name: name,
      ),
    );
    return responsse.toListEntity();
  }

  @override
  Future<void> createQuestion(
      {required CreateQuestionInput CreateQuestionInput}) async {
    return await _postService.createQuestion(
        CreateQuestionInput: CreateQuestionInput);
  }

  @override
  Future<TagEntity> createTag({required String name}) async {
    final tag = await _postService.createTags(name: name);
    return tag.data.toEntity();
  }
}
