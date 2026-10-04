import '../entities/category_entity.dart';
import '../../../home/domain/entities/question_respose_entity.dart';

import '../../../../data/data_sources/remotes/category_service.dart';

abstract class CategoryRepository {
  Future<void> deleteCategory(int id);
  Future<void> deleteQuestionInCateogry(int id);
  Future<CategoryEntity> editCategory(EditCategoryInput input);
  Future<QuestionResposeEntity> getQuestion({required IdPageInput input});
  Future<List<CategoryEntity>> GetCategoryEvent();
  Future<void> merge({required Mergeinput mergeinput});
  Future<CategoryEntity> createCategory(
      {required CreateCategoryInput createCategoryInput});
  Future<void> saveQuestionToCategory(
      {required SaveQuestionInput SaveQuestionInput});
  Future<void> reorderCategory({required ReOrderCategoryInput input});
}
