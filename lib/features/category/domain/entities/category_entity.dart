// class CategoryEntity {
// final int id;
// String name;
// String cover;
// int count;
//   CategoryEntity({
//     required this.id,
//     required this.name,
//     required this.cover,
//     this.count = 0,
//   });
// }
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  factory CategoryEntity({
    @Default(0) int id,
    @Default('') String? name,
    @Default('') String? cover,
    @Default(0) int? count,
  }) = _CategoryEntity;
}
