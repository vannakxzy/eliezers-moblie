import 'package:json_annotation/json_annotation.dart';
import '../../../features/splash_page/domain/entities/slogan_entity.dart';
part 'slogan_model.g.dart';

@JsonSerializable(createToJson: true)
class SloganModel extends SloganEntity {
  SloganModel({required super.data});
  factory SloganModel.fromJson(Map<String, dynamic> json) =>
      _$SloganModelFromJson(json);
}
