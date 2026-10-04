import 'package:injectable/injectable.dart';
import '../../../../app/base/navigation/app_navigator.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';

@Injectable()
class LogoutUseCase extends BaseUseCase<void, void> {
  LogoutUseCase(this.appRoute);
  final IAppNavigator appRoute;
  @override
  Future<void> excecute([input]) async {
    await LocalStorage.remove(SharedPreferenceKeys.accessToken);
    await appRoute.replaceAll([const AppRouteInfo.login()]);
  }
}
