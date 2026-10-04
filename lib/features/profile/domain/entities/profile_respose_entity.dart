import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/profile/profile_model.dart';

import '../../../../data/models/meta_model.dart';
part 'profile_respose_entity.freezed.dart';

@freezed
class ProfileResposeEntity with _$ProfileResposeEntity {
  factory ProfileResposeEntity({
    @Default([]) List<ProfileModel> data,
    MetaModel? mate,
  }) = _ProfileResposeEntity;
}
