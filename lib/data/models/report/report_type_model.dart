import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/report/domain/entities/report_type_entity.dart';
part 'report_type_model.g.dart';

@JsonSerializable(createToJson: true)
class ReportTypeModel extends ReportTypeEntity {
  ReportTypeModel({required super.id, required super.name});
  factory ReportTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ReportTypeModelFromJson(json);
}
