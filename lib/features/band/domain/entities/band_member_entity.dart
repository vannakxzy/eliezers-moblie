import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import 'band_entity.dart';

part 'band_member_entity.freezed.dart';

@freezed
class bandMemberEntity with _$bandMemberEntity {
  factory bandMemberEntity({
    @Default(0) int id,
    @Default('') String status,
    @Default('') String role,
    @Default('') String createAt,
    @Default(ProfileEntity()) ProfileEntity user,
    @Default(BandEntity()) BandEntity band,
  }) = _BandEntity;
}
