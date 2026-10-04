import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/answer_respose_entity.dart';
import '../repository/profile_repository.dart';

@Injectable()
class GetAnswerByUserUserCase extends BaseUseCase<int, AnswerResposeEntity> {
  final ProfileRepository _ProfileRepository;
  GetAnswerByUserUserCase(this._ProfileRepository);
  @override
  Future<AnswerResposeEntity> excecute(int input) async {
    return await _ProfileRepository.getAnswer(input);
  }
}
