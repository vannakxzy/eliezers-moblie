import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/report_type_entity.dart';
import '../repository/report_repository.dart';

@Injectable()
class GetReportTypeUseCase extends BaseUseCase<void, List<ReportTypeEntity>> {
  final ReportRepository _reportRepository;
  GetReportTypeUseCase(this._reportRepository);
  @override
  Future<List<ReportTypeEntity>> excecute(void input) async {
    return await _reportRepository.getreportType();
  }
}
