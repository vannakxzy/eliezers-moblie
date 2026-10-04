import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/question_model.dart';

part 'hide_entity.freezed.dart';

@freezed
class HideEntity with _$HideEntity {
  factory HideEntity({
    int? id,
    String? date,
    QuestionModel? data,
  }) = _HideEntity;
}
