import 'package:freezed_annotation/freezed_annotation.dart';
part 'active_session_entity.freezed.dart';

@freezed
class ActiveSessionEntity with _$ActiveSessionEntity {
  factory ActiveSessionEntity({
    int? id,
    int? userId,
    String? country,
    String? countryCode,
    String? region,
    String? regionName,
    String? city,
    String? zip,
    String? lat,
    String? lon,
    String? timezone,
    String? isp,
    String? org,
    String? as,
    String? manufacturer,
    String? model,
    String? createdAt,
    String? updatedAt,
  }) = _ActiveSessionEntity;
}
