import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/band/band_member_model.dart';
import '../../../../data/models/meta_model.dart';

part 'band_member_respose_entity.freezed.dart';

@freezed
class BandMemberResposeEntity with _$BandMemberResposeEntity {
  factory BandMemberResposeEntity({
    @Default([]) List<BandMemberModel> data,
    MetaModel? mate,
  }) = _BandResposeEntity;
}
