import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/question_model.dart';

import '../../../../data/models/meta_model.dart';

part 'question_respose_entity.freezed.dart';

@freezed
class QuestionResposeEntity with _$QuestionResposeEntity {
  factory QuestionResposeEntity({
    @Default([]) List<QuestionModel> data,
    MetaModel? mate,
  }) = _QuestionResposeEntity;
}
