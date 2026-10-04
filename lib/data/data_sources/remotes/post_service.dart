import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/post_question/tag_model.dart';

import '../../../app/base/response/base_data_response.dart';

part 'post_service.g.dart';

@LazySingleton()
@RestApi()
abstract class PostService {
  @FactoryMethod()
  factory PostService(Dio dio) = _PostService;

  @GET(ApiEndpoints.getTags)
  Future<List<TagModel>> getTag({@Body() required TagInput tagInput});

  @POST(ApiEndpoints.createQuestion)
  Future<void> createQuestion(
      {@Body() required CreateQuestionInput CreateQuestionInput});

  @POST(ApiEndpoints.createTag)
  Future<DataResponse<TagModel>> createTags({
    @Field('name') required String name,
  });
}

@JsonSerializable(createToJson: true)
class TagInput {
  final List<int> oldTag;
  final String name;
  TagInput({required this.oldTag, required this.name});
  Map<String, dynamic> toJson() => _$TagInputToJson(this);
}

@JsonSerializable(createToJson: true)
class CreateQuestionInput {
  final String title;
  final String description;
  final List<int> tags;
  final String image;
  final String visibility;
  final int band_id;
  final bool is_discussion;
  CreateQuestionInput(
      {required this.description,
      required this.image,
      required this.tags,
      required this.title,
      this.band_id = 0,
      this.is_discussion = false,
      this.visibility = "public"});
  Map<String, dynamic> toJson() => _$CreateQuestionInputToJson(this);
}
