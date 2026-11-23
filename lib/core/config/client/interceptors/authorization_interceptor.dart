import 'package:dio/dio.dart';

import '../../../constants/constants.dart';
import '../../../extension/string_extension.dart';
import '../../../helper/local_data/storge_local.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String token =
        LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);

    if (token.isNotEmptyOrNull) {
      options.headers.addAll({
        'Authorization': 'Bearer $token',
        'X-YVP-App-Key': 'XvQ97ofN9BGk89y2McGp1gIgNW0xiIQGZLAR1I40bwV4AK2H'
      });
    }
    super.onRequest(options, handler);
  }
}
