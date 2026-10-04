import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import '../repository/report_repository.dart';

@Injectable()
class CreateReportUsecase extends BaseUseCase<ReportInput, void> {
  final ReportRepository _reportRepository;
  CreateReportUsecase(this._reportRepository);
  @override
  Future<void> excecute(ReportInput input) async {
    return await _reportRepository.createReport(input);
  }
}
