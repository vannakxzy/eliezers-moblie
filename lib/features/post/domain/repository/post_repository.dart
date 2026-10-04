import '../../../../data/data_sources/remotes/post_service.dart';
import '../entities/tag_entity.dart';

abstract class PostRepository {
  Future<List<TagEntity>> getTag(
      {required String name, required List<int> oldTag});
  Future<void> createQuestion(
      {required CreateQuestionInput CreateQuestionInput});
  Future<TagEntity> createTag({required String name});
}
