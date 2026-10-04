import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/band/band_model.dart';
import '../../../../data/models/meta_model.dart';

part 'band_respose_entity.freezed.dart';

@freezed
class BandResposeEntity with _$BandResposeEntity {
  factory BandResposeEntity({
    @Default([]) List<BandModel> data,
    PaginationModel? pagination,
  }) = _BandResposeEntity;
}
