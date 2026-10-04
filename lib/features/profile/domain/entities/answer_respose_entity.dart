import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/meta_model.dart';

import '../../../../data/models/profile/answer_model.dart';
part 'answer_respose_entity.freezed.dart';

@freezed
class AnswerResposeEntity with _$AnswerResposeEntity {
  factory AnswerResposeEntity({
    @Default([]) List<AnswerModel> data,
    MetaModel? mate,
  }) = _AnswerResposeEntity;
}
