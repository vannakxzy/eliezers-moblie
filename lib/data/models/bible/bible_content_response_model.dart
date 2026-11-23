import 'package:json_annotation/json_annotation.dart';

import 'bible_content_model.dart';

part 'bible_content_response_model.g.dart';

@JsonSerializable()
class BibleContentResponseModel {
  BibleContentResponseModel({this.data});

  List<BibleContentModel>? data;

  factory BibleContentResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BibleContentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BibleContentResponseModelToJson(this);

  factory BibleContentResponseModel.fromListJson(
    List<dynamic> json,
  ) {
    return BibleContentResponseModel(
      data: json
          .map((item) => BibleContentModel.fromJson(
                item as Map<String, dynamic>,
              ))
          .toList(),
    );
  }
}
