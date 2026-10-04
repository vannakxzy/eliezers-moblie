import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/post_question/tag_model.dart';

import '../../../../data/models/meta_model.dart';

part 'tag_respose_entity.freezed.dart';

@freezed
class TagResposeEntity with _$TagResposeEntity {
  factory TagResposeEntity({
    @Default([]) List<TagModel> data,
    MetaModel? mate,
  }) = _TagResposeEntity;
}
