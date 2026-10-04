import '../entities/report_type_detail_entity.dart';
import '../entities/report_type_entity.dart';

import '../../../../data/data_sources/remotes/report_api_service.dart';

abstract class ReportRepository {
  Future<List<ReportTypeEntity>> getreportType();
  Future<List<ReportTypeDetailEntity>> getReportTypeDetail({required int id});
  Future<void> createReport(ReportInput reportInput);
}
