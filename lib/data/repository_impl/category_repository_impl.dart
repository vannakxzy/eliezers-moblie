import 'package:injectable/injectable.dart';
import '../data_sources/remotes/category_service.dart';
import '../models/category/category_model.dart';
import '../models/homes/question_respose_model.dart';
import '../../features/category/domain/entities/category_entity.dart';
import '../../features/category/domain/repository/category_repository.dart';
import '../../features/home/domain/entities/question_respose_entity.dart';

@Injectable(as: CategoryRepository)
class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl(this._categoryService);
  final CategoryService _categoryService;

  @override
  Future<List<CategoryEntity>> GetCategoryEvent() async {
    final category = await _categoryService.getCategoryEvent();
    return category.toListEntity();
  }

  @override
  Future<void> merge({required Mergeinput mergeinput}) async {
    return await _categoryService.mergeCategory(mergeinput: mergeinput);
  }

  @override
  Future<CategoryEntity> createCategory(
      {required CreateCategoryInput createCategoryInput}) async {
    final cateogry = await _categoryService.createCategory(
        createCategoryInput: createCategoryInput);
    return cateogry.toEntity();
  }

  @override
  Future<void> saveQuestionToCategory(
      {required SaveQuestionInput SaveQuestionInput}) async {
    return await _categoryService.saveQuestiontoCateogry(
        SaveQuestionInput: SaveQuestionInput);
  }

  @override
  Future<void> deleteCategory(int id) async {
    return await _categoryService.deleteCategory(id);
  }

  @override
  Future<CategoryEntity> editCategory(EditCategoryInput input) async {
    final category = await _categoryService.editCategory(input: input);
    return category.toEntity();
  }

  @override
  Future<void> deleteQuestionInCateogry(int id) async {
    return await _categoryService.deleteSaveQuestion(id);
  }

  @override
  Future<QuestionResposeEntity> getQuestion(
      {required IdPageInput input}) async {
    final quesiton =
        await _categoryService.GetQuestioninCategoryEvent(input: input);
    return quesiton.toEntity();
  }

  @override
  Future<void> reorderCategory({required ReOrderCategoryInput input}) async {
    await _categoryService.reorderCategory(input: input);
  }
}
