import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/meta_model.dart';

import '../../../../data/models/security_login/hide_model.dart';
part 'hide_respose_entity.freezed.dart';

@freezed
class HideResposeEntity with _$HideResposeEntity {
  factory HideResposeEntity({
    @Default([]) List<HideModel>? data,
    MetaModel? meta,
  }) = _HideResposeEntity;
}
