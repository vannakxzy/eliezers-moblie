import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/report_type_detail_entity.dart';
import '../repository/report_repository.dart';

@Injectable()
class GetReportTypeDetialUseCase
    extends BaseUseCase<int, List<ReportTypeDetailEntity>> {
  final ReportRepository _reportRepository;
  GetReportTypeDetialUseCase(this._reportRepository);
  @override
  Future<List<ReportTypeDetailEntity>> excecute(input) async {
    return await _reportRepository.getReportTypeDetail(id: input);
  }
}
