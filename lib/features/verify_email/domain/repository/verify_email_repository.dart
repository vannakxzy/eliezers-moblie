import '../../../../data/data_sources/remotes/verify_email_api_service.dart';
import '../entity/verify_email_entity.dart';

abstract class VerifyEmailRepository {
  Future<void> sendOtp({required VerifyOtpInput input});
  Future<VerifyEmailEntity> verifyOtp({required VerifyOtpInput verifyOtpInput});
}
