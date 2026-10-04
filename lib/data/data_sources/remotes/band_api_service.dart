import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/constants.dart';
import '../../models/band/band_member_respose_model.dart';
import '../../models/band/band_model.dart';
import '../../models/band/band_respose_model.dart';
import '../../models/homes/question_respose_model.dart';

part 'band_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class BandApiService {
  @FactoryMethod()
  factory BandApiService(Dio dio) = _BandApiService;
  @GET(ApiEndpoints.getOwnPermissionInband)
  Future<void> getOwnPermissionInband({@Query("band_id") required int band_id});
  @GET(ApiEndpoints.getQuestionInband)
  Future<QuestionResposeModel> getQuestionInband(
      {@Body() required bandIdPageInput input});
  @GET(ApiEndpoints.bandMember)
  Future<BandMemberResposeModel> getbandMember(
      {@Body() required bandIdPageInput input});
  @GET(ApiEndpoints.band)
  Future<bandResposeModel> getband({@Body() required GetbandInput input});
  @GET("${ApiEndpoints.band}/{id}")
  Future<BandModel> findCommuntiy(@Path("id") int bandId);
  @GET(ApiEndpoints.searchband)
  Future<bandResposeModel> searchband({@Body() required SearchInput input});
  @POST(ApiEndpoints.band)
  Future<BandModel> createband({@Body() required bandInput input});
  @GET(ApiEndpoints.getbandinUser)
  Future<bandResposeModel> getbandInUser(
      {@Body() required GetbandInUserInput input});
  @POST(ApiEndpoints.joinband)
  Future<void> joinband({@Query("band_id") required int band_id});
  @POST(ApiEndpoints.requestToJoinband)
  Future<void> requestToJoinband({@Query("band_id") required int band_id});
  @POST(ApiEndpoints.approveUserInband)
  Future<void> approveUserInband({@Body() required BandIdUserIdInput input});
  @POST(ApiEndpoints.rejectUserInband)
  Future<void> rejectUserInband({@Body() required BandIdUserIdInput input});
  @POST(ApiEndpoints.leaveband)
  Future<void> leaveband({@Query("band_id") required int band_id});
  @POST(ApiEndpoints.removeMemberband)
  Future<void> removeMemberband({@Body() required BandIdUserIdInput input});
  @DELETE("${ApiEndpoints.bandMember}/cancel")
  Future<void> cancelReqeustband({@Query("band_id") required int band_id});
  @POST(ApiEndpoints.updatebandRole)
  Future<void> updatebandRole({@Body() required bandMemberInput input});
  @PUT(ApiEndpoints.band)
  Future<void> updateband({@Body() required bandInput input});
  @PUT(ApiEndpoints.bandPermission)
  Future<void> updateCommunitPermission(
      {@Body() required bandPermissionInput input});
  @DELETE("${ApiEndpoints.band}/{id}")
  Future<bandResposeModel> deleteband(@Path("id") int bandId);
  @DELETE("${ApiEndpoints.bandMember}/{id}")
  Future<bandResposeModel> removebandMember(@Path("id") int bandId);
  @PUT("${ApiEndpoints.band}/read-message/{id}")
  Future<void> readMessage(@Path("id") int bandId);
  @POST("${ApiEndpoints.bandMember}/add")
  Future<bandResposeModel> addMember(
      {@Body() required AddbandMemberInput input});

  @GET("${ApiEndpoints.bandMember}/get-all-request")
  Future<BandMemberResposeModel> gerAllRequest(
      {@Body() required SearchInput input});
}

@JsonSerializable(createToJson: true)
class SearchInput {
  final String q;
  final int page;
  SearchInput({this.q = '', this.page = 1});
  Map<String, dynamic> toJson() => _$SearchInputToJson(this);
}

@JsonSerializable(createToJson: true)
class GetbandInput {
  final String q;
  final int page;
  final String status;
  GetbandInput({required this.q, this.page = 1, this.status = ''});
  Map<String, dynamic> toJson() => _$GetbandInputToJson(this);
}

@JsonSerializable(createToJson: true)
class bandIdPageInput {
  final int band_id;
  final int page;
  final String name;
  bandIdPageInput({required this.band_id, this.page = 1, this.name = ''});
  Map<String, dynamic> toJson() => _$bandIdPageInputToJson(this);
}

@JsonSerializable(createToJson: true)
class bandMemberInput {
  final int user_id;
  final int band_id;
  final String role;
  bandMemberInput({required this.user_id, this.band_id = 1, this.role = ''});
  Map<String, dynamic> toJson() => _$bandMemberInputToJson(this);
}

@JsonSerializable(createToJson: true)
class AddbandMemberInput {
  final List<int> user_id;
  final int band_id;
  final String role;
  AddbandMemberInput(
      {required this.user_id, required this.band_id, required this.role});
  Map<String, dynamic> toJson() => _$AddbandMemberInputToJson(this);
}

@JsonSerializable(createToJson: true)
class BandIdUserIdInput {
  final int user_id;
  final int band_id;
  final int notification_id;
  BandIdUserIdInput(
      {required this.user_id, this.band_id = 1, this.notification_id = 0});
  Map<String, dynamic> toJson() => _$BandIdUserIdInputToJson(this);
}

@JsonSerializable(createToJson: true)
class GetbandInUserInput {
  final int user_id;
  final int page;
  GetbandInUserInput({required this.user_id, this.page = 1});
  Map<String, dynamic> toJson() => _$GetbandInUserInputToJson(this);
}

@JsonSerializable(createToJson: true)
class bandInput {
  final int id;
  final String name;
  final String description;
  final String image;
  final bool is_private;
  bandInput(
      {required this.description,
      required this.name,
      this.image = '',
      this.id = 0,
      this.is_private = false});
  Map<String, dynamic> toJson() => _$bandInputToJson(this);
}

@JsonSerializable(createToJson: true)
class bandPermissionInput {
  final int id;
  final int band_id;
  final bool invite_link_only;
  final bool create_question;
  final bool create_discussion;
  final bool add_member;
  final bool send_message;
  final bool reaction;
  final bool change_info;
  bandPermissionInput({
    this.id = 0,
    this.band_id = 0,
    this.invite_link_only = false,
    this.create_question = false,
    this.create_discussion = false,
    this.add_member = false,
    this.send_message = false,
    this.change_info = false,
    this.reaction = false,
  });
  Map<String, dynamic> toJson() => _$bandPermissionInputToJson(this);
}
