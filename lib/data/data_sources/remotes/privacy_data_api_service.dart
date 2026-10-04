import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'privacy_data_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class PrivacyDataApiService{
  @FactoryMethod()
  factory PrivacyDataApiService(Dio dio) = _PrivacyDataApiService;

  // all `PrivacyData` request abstract here
}