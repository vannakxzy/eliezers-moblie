import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/search/domain/entities/popular_search_entity.dart';
part 'popular_search_model.g.dart';

@JsonSerializable()
class PopularSearchModel extends PopularSearchEntity {
  PopularSearchModel({
    required super.image,
    required super.parameter,
    required super.title,
  });
  factory PopularSearchModel.fromJson(Map<String, dynamic> json) =>
      _$PopularSearchModelFromJson(json);
}
