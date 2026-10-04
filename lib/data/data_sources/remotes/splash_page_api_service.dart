import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../app/base/response/base_data_response.dart';
import '../../../core/constants/api_constants.dart';

part 'splash_page_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class SplashPageApiService {
  @FactoryMethod()
  factory SplashPageApiService(Dio dio) = _SplashPageApiService;

  // all `SplashPage` request abstract here
  @GET(ApiEndpoints.getSlogan)
  Future<DataResponse<String>> getSlogan();
}
