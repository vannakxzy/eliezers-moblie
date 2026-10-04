import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_entity.freezed.dart';

@freezed
class SubjectEntity with _$SubjectEntity {
  factory SubjectEntity({
    int? id,
    String? title,
  }) = _SubjectEntity;
}
