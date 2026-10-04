import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/verify_email_api_service.dart';
import '../../../verify_email/domain/repository/verify_email_repository.dart';

@Injectable()
class SendOtpUsecase extends BaseUseCase<VerifyOtpInput, void> {
  final VerifyEmailRepository _personalInfoRepository;
  SendOtpUsecase(this._personalInfoRepository);
  @override
  Future<void> excecute(VerifyOtpInput input) async {
    return await _personalInfoRepository.sendOtp(input: input);
  }
}
