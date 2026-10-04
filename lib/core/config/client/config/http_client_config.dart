import 'package:injectable/injectable.dart';

import '../../../../data/data_sources/locals/app_service.dart';
import '../../../constants/api_constants.dart';

abstract class IConfig {
  String get baseUrl;

  Map<String, String> get headers;
}

@Injectable(as: IConfig)
class AppConfig extends IConfig {
  AppConfig(this._appService);

  final AppService _appService;
  @override
  String get baseUrl => BaseUrls.baseUrl;

  @override
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Accept-Language': _appService.locale,
      };
}
