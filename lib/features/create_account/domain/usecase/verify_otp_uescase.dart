import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/verify_email_api_service.dart';
import '../../../verify_email/domain/repository/verify_email_repository.dart';

import '../../../verify_email/domain/entity/verify_email_entity.dart';

@Injectable()
class VerifyOtpUescase extends BaseUseCase<VerifyOtpInput, VerifyEmailEntity> {
  final VerifyEmailRepository _verifyEmailRepository;
  VerifyOtpUescase(this._verifyEmailRepository);
  @override
  Future<VerifyEmailEntity> excecute(VerifyOtpInput input) async {
    return await _verifyEmailRepository.verifyOtp(verifyOtpInput: input);
  }
}
