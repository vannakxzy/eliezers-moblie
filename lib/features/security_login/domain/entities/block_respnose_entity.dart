import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/meta_model.dart';
import '../../../../data/models/security_login/block_model.dart';
part 'block_respnose_entity.freezed.dart';

@freezed
class BlockRespnoseEntity with _$BlockRespnoseEntity {
  factory BlockRespnoseEntity({
    @Default([]) List<BlockModel>? data,
    MetaModel? meta,
  }) = _BlockRespnoseEntity;
}
