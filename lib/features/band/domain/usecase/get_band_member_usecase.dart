import 'package:injectable/injectable.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../entities/band_member_respose_entity.dart';
import '../repository/band_repository.dart';

@Injectable()
class GetbandMemberUsecase
    implements BaseUseCase<bandIdPageInput, BandMemberResposeEntity> {
  final BandRepository _repository;
  GetbandMemberUsecase(this._repository);
  @override
  Future<BandMemberResposeEntity> excecute(input) async {
    return await _repository.getbandMember(input);
  }
}
