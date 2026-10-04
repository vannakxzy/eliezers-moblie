import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part '{{name.snakeCase()}}_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class {{name.pascalCase()}}ApiService{
  @FactoryMethod()
  factory {{name.pascalCase()}}ApiService(Dio dio) = _{{name.pascalCase()}}ApiService;

  // all `{{name.pascalCase()}}` request abstract here
}