import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/search_service.dart';
import '../../../profile/domain/entities/profile_respose_entity.dart';
import '../repository/search_repository.dart';

@Injectable()
class GetSearchUserUsecase
    extends BaseUseCase<UserInput, ProfileResposeEntity> {
  final SearchRepository _repository;
  GetSearchUserUsecase(this._repository);

  @override
  Future<ProfileResposeEntity> excecute(UserInput input) async {
    return await _repository.getUser(input);
  }
}
