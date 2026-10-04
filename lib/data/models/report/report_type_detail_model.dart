import 'package:json_annotation/json_annotation.dart';
import '../../../features/report/domain/entities/report_type_detail_entity.dart';
part 'report_type_detail_model.g.dart';

@JsonSerializable(createToJson: true)
class ReportTypeDetailModel extends ReportTypeDetailEntity {
  ReportTypeDetailModel({required super.id, required super.name});
  factory ReportTypeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ReportTypeDetailModelFromJson(json);
}
