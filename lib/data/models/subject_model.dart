import 'package:json_annotation/json_annotation.dart';

import '../../features/home/domain/entities/subject_entity.dart';

part 'subject_model.g.dart';

@JsonSerializable(createToJson: false)
class SubjectModel {
  SubjectModel({
    required this.id,
    required this.title,
  });

  final int? id;
  final String? title;

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
}

/// Map to Entity
extension SubjectModelToEntity on SubjectModel {
  SubjectEntity toEntity() => SubjectEntity(
        id: id,
        title: title,
      );
}

extension SubjectModelToListEntity on List<SubjectModel> {
  List<SubjectEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
