import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../models/homes/question_respose_model.dart';
import '../../models/profile/answer_respose_model.dart';
import '../../models/search/tag_respose_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';

import '../../models/profile/profile_respose_model.dart';
import '../../models/search/popular_search_model.dart';

part 'search_service.g.dart';

@LazySingleton()
@RestApi()
abstract class SearchService {
  @FactoryMethod()
  factory SearchService(Dio dio) = _SearchService;
  @GET(ApiEndpoints.getpopularSearch)
  Future<List<PopularSearchModel>> getpopularSearch();
  @GET(ApiEndpoints.getSearchQuestion)
  Future<QuestionResposeModel> getResultSearch(
      {@Body() required QPageInput input});
  @GET(ApiEndpoints.getSearchtAnswer)
  Future<AnswerResposeModel> getSearchAnswer(
      {@Body() required QPageInput input});
  @GET(ApiEndpoints.getSearchUser)
  Future<ProfileResposeModel> getSearchUser({@Body() required UserInput input});
  @GET(ApiEndpoints.getTagCount)
  Future<TagResposeModel> getTag({@Body() required QPageInput input});

  @GET(ApiEndpoints.getquestionbyTag)
  Future<QuestionResposeModel> getQuestionByTag(
      {@Body() required GetQuestionByTagInput input});
}

@JsonSerializable(createToJson: true)
class UserInput {
  final String q;
  final int page;
  final int band_id;
  UserInput({
    required this.q,
    required this.page,
    this.band_id = 0,
  });
  Map<String, dynamic> toJson() => _$UserInputToJson(this);
}

@JsonSerializable(createToJson: true)
class QPageInput {
  final String q;
  final int page;
  QPageInput({
    required this.q,
    required this.page,
  });
  Map<String, dynamic> toJson() => _$QPageInputToJson(this);
}

@JsonSerializable(createToJson: true)
class GetQuestionByTagInput {
  final int tag_id;
  final int page;
  GetQuestionByTagInput({
    required this.tag_id,
    required this.page,
  });
  Map<String, dynamic> toJson() => _$GetQuestionByTagInputToJson(this);
}
