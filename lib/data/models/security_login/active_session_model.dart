import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/security_login/domain/entities/active_session_entity.dart';
part 'active_session_model.g.dart';

@JsonSerializable()
class ActiveSessionModel {
  ActiveSessionModel({
    this.id,
    this.userId,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.as,
    this.manufacturer,
    this.model,
    this.createdAt,
    this.updatedAt,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'country_code')
  final String? countryCode;
  @JsonKey(name: 'region')
  final String? region;
  @JsonKey(name: 'region_name')
  final String? regionName;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'zip')
  final String? zip;
  @JsonKey(name: 'lat')
  final String? lat;
  @JsonKey(name: 'lon')
  final String? lon;
  @JsonKey(name: 'timezone')
  final String? timezone;
  @JsonKey(name: 'isp')
  final String? isp;
  @JsonKey(name: 'org')
  final String? org;
  @JsonKey(name: 'as')
  final String? as;
  @JsonKey(name: 'manufacturer')
  final String? manufacturer;
  @JsonKey(name: 'model')
  final String? model;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  factory ActiveSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveSessionModelFromJson(json);
}

extension ActiveSessionModelToEntity on ActiveSessionModel {
  ActiveSessionEntity toEntity() => ActiveSessionEntity(
      id: id ?? 0,
      as: as,
      city: city,
      country: country,
      countryCode: countryCode,
      createdAt: createdAt,
      isp: isp,
      lat: lat,
      lon: lon,
      manufacturer: manufacturer,
      model: model,
      org: org,
      region: region,
      regionName: regionName,
      timezone: timezone,
      updatedAt: updatedAt,
      userId: userId,
      zip: zip);
}

extension ActiveSessionModelToListEntity on List<ActiveSessionModel> {
  List<ActiveSessionEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
