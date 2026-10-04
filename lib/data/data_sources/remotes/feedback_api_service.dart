import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/api_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'feedback_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class FeedbackApiService {
  @FactoryMethod()
  factory FeedbackApiService(Dio dio) = _FeedbackApiService;
  @POST(ApiEndpoints.submitFeedback)
  Future<void> submitFeedback(@Query('descrption') String description);
}
