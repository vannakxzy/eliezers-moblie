import 'package:injectable/injectable.dart';
import '../data_sources/remotes/splash_page_api_service.dart';

import '../../features/splash_page/domain/repository/splash_page_repository.dart';

@LazySingleton(as: SplashPageRepository)
class SplashPageRepositoryImpl implements SplashPageRepository {
  final SplashPageApiService _apiService;
  SplashPageRepositoryImpl(this._apiService);
  @override
  Future<String> getSlogan() async {
    final slogan = await _apiService.getSlogan();
    return slogan.data;
  }
}
