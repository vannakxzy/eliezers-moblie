import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/meta_model.dart';
import '../../../../data/models/musics/musics_model.dart';

part 'music_respose_entity.freezed.dart';

@freezed
class MusicsResposeEntity with _$MusicsResposeEntity {
  factory MusicsResposeEntity({
    @Default([]) List<MusicsModel> data,
    PaginationModel? pagination,
  }) = _MusicsResposeEntity;
}
