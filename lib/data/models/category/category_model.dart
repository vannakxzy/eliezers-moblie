import 'package:json_annotation/json_annotation.dart';
import '../../../features/category/domain/entities/category_entity.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.cover,
    required this.count,
  });
  final int? id;
  final String? name;
  final String? cover;
  final int? count;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

extension CategoryModelToEntity on CategoryModel {
  CategoryEntity toEntity() => CategoryEntity(
        count: count ?? 0,
        cover: cover ?? "",
        id: id ?? 0,
        name: name ?? "",
      );
}

extension CategoryModelToListEntity on List<CategoryModel> {
  List<CategoryEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
