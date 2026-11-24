import 'package:injectable/injectable.dart';

import '../../../../data/data_sources/locals/app_service.dart';
import '../../../constants/api_constants.dart';
import '../../../constants/shared_preference_keys_constants.dart';
import '../../../helper/local_data/storge_local.dart';

abstract class IConfig {
  String get baseUrl;
  String get bibleUrl;
  String get musicUrl;
  Map<String, String> get headers;
}

@Injectable(as: IConfig)
class AppConfig extends IConfig {
  AppConfig(this._appService);

  final AppService _appService;
  @override
  String get baseUrl => BaseUrls.baseUrl;
  
  @override
  String get bibleUrl => BaseUrls.bibleUrl;

  @override
  String get musicUrl => BaseUrls.bibleUrl;

final String token =
      LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);
  @override
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Accept-Language': _appService.locale,
        'X-YVP-App-Key': 'XvQ97ofN9BGk89y2McGp1gIgNW0xiIQGZLAR1I40bwV4AK2H',
        'Authorization': 'Bearer $token',

      };

}
