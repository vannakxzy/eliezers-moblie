import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../models/profile/profile_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';

part 'personal_info_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class PersonalInfoApiService {
  @FactoryMethod()
  factory PersonalInfoApiService(Dio dio) = _PersonalInfoApiService;

  @GET(ApiEndpoints.checkUserName)
  Future<int> checkUserName({@Query('user_name') required String userName});
  @GET(ApiEndpoints.checkEmail)
  Future<int> checkEmail({@Field('email') required String email});
  @PUT(ApiEndpoints.updatePersonalInfo)
  Future<ProfileModel> updatePersonalInfo(
      {@Body() required UpdatePersonalInfoInput updatePersonalInfoInput});
  @PUT(ApiEndpoints.updatePersonalInfo)
  Future<void> updateProfile({@Field('profile') required String profile});
}

@JsonSerializable(createToJson: true)
class UpdatePersonalInfoInput {
  UpdatePersonalInfoInput(
      {this.name, this.bio, this.username, this.profile, this.email});

  final String? name;
  final String? bio;
  final String? email;
  @JsonKey(name: 'user_name')
  final String? username;

  final String? profile;

  factory UpdatePersonalInfoInput.fromJson(Map<String, dynamic> json) =>
      _$UpdatePersonalInfoInputFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePersonalInfoInputToJson(this);
}
