import 'package:injectable/injectable.dart';
import '../data_sources/remotes/verify_email_api_service.dart';

import '../../features/verify_email/domain/entity/verify_email_entity.dart';
import '../../features/verify_email/domain/repository/verify_email_repository.dart';

@LazySingleton(as: VerifyEmailRepository)
class VerifyEmailRepositoryImpl implements VerifyEmailRepository {
  final VerifyEmailApiService _verifyEmailApiService;
  VerifyEmailRepositoryImpl(this._verifyEmailApiService);

  @override
  Future<VerifyEmailEntity> verifyOtp({required verifyOtpInput}) async {
    return await _verifyEmailApiService.verifyOtp(
        verifyOtpInput: verifyOtpInput);
  }

  @override
  Future<void> sendOtp({required VerifyOtpInput input}) async {
    return await _verifyEmailApiService.sendOtp(input: input);
  }
}
