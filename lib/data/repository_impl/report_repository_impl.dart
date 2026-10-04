import 'package:injectable/injectable.dart';
import '../data_sources/remotes/report_api_service.dart';
import '../../features/report/domain/entities/report_type_detail_entity.dart';
import '../../features/report/domain/entities/report_type_entity.dart';

import '../../features/report/domain/repository/report_repository.dart';

@LazySingleton(as: ReportRepository)
class ReportRepositoryImpl implements ReportRepository {
  final ReportApiService _reportApiService;
  ReportRepositoryImpl(this._reportApiService);
  @override
  Future<List<ReportTypeEntity>> getreportType() async {
    return await _reportApiService.getReportType();
  }

  @override
  Future<List<ReportTypeDetailEntity>> getReportTypeDetail(
      {required int id}) async {
    return await _reportApiService.getReportTypeDetail(id);
  }

  @override
  Future<void> createReport(ReportInput reportInput) async {
    return await _reportApiService.createReport(reportInput: reportInput);
  }
}
