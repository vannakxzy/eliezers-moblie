import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../models/homes/question_respose_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/category/category_model.dart';

part "category_service.g.dart";

@LazySingleton()
@RestApi()
abstract class CategoryService {
  @FactoryMethod()
  factory CategoryService(Dio dio) = _CategoryService;

  @GET(ApiEndpoints.GetCategoryEvent)
  Future<List<CategoryModel>> getCategoryEvent();

  @POST(ApiEndpoints.mergeCategroy)
  Future<void> mergeCategory({@Body() required Mergeinput mergeinput});

  @POST(ApiEndpoints.createCategory)
  Future<CategoryModel> createCategory(
      {@Body() required CreateCategoryInput createCategoryInput});

  @POST(ApiEndpoints.saveQuestiontoCateogry)
  Future<void> saveQuestiontoCateogry(
      {@Body() required SaveQuestionInput SaveQuestionInput});

  @GET(ApiEndpoints.getQuesitonInCategory)
  Future<QuestionResposeModel> GetQuestioninCategoryEvent(
      {@Body() required IdPageInput input});
  @POST(ApiEndpoints.deleteCategory)
  Future<void> deleteCategory(@Query('id') int? id);
  @POST(ApiEndpoints.reorderCategory)
  Future<void> reorderCategory({@Body() required ReOrderCategoryInput input});
  @DELETE(ApiEndpoints.deleteSaveQuestion)
  Future<void> deleteSaveQuestion(@Query('question_id') int? questionId);

  @PUT(ApiEndpoints.editCategory)
  Future<CategoryModel> editCategory(
      {@Body() required EditCategoryInput input});
}

@JsonSerializable(createToJson: true)
class EditCategoryInput {
  EditCategoryInput({
    this.id,
    this.name,
    this.cover,
  });
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'cover')
  final String? cover;

  factory EditCategoryInput.fromJson(Map<String, dynamic> json) =>
      _$EditCategoryInputFromJson(json);

  Map<String, dynamic> toJson() => _$EditCategoryInputToJson(this);
}

@JsonSerializable(createToJson: true)
class SaveQuestionInput {
  final int save_category_id;
  final int question_id;
  SaveQuestionInput(
      {required this.question_id, required this.save_category_id});
  Map<String, dynamic> toJson() => _$SaveQuestionInputToJson(this);
}

@JsonSerializable(createToJson: true)
class CreateCategoryInput {
  final String? name;
  final String? cover;
  CreateCategoryInput({
    required this.cover,
    required this.name,
  });
  factory CreateCategoryInput.fromJson(Map<String, dynamic> json) =>
      _$CreateCategoryInputFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCategoryInputToJson(this);
}

@JsonSerializable(createToJson: true)
class Mergeinput {
  Mergeinput({
    this.from,
    this.to,
  });
  final int? from;
  final int? to;
  factory Mergeinput.fromJson(Map<String, dynamic> json) =>
      _$MergeinputFromJson(json);

  Map<String, dynamic> toJson() => _$MergeinputToJson(this);
}

@JsonSerializable(createToJson: true)
class IdPageInput {
  IdPageInput({
    this.id,
    this.page,
  });
  final int? id;
  final int? page;
  factory IdPageInput.fromJson(Map<String, dynamic> json) =>
      _$IdPageInputFromJson(json);

  Map<String, dynamic> toJson() => _$IdPageInputToJson(this);
}

@JsonSerializable(createToJson: true)
class ReOrderCategoryInput {
  ReOrderCategoryInput({
    this.oldId,
    this.newId,
  });
  final int? oldId;
  final int? newId;
  factory ReOrderCategoryInput.fromJson(Map<String, dynamic> json) =>
      _$ReOrderCategoryInputFromJson(json);
  Map<String, dynamic> toJson() => _$ReOrderCategoryInputToJson(this);
}
