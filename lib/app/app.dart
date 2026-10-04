import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../config/router/app_router.dart';
import '../config/theme/theme_controller.dart';
import '../core/constants/constants.dart';
import '../core/helper/local_data/storge_local.dart';
import '../core/utils/controllers/app_controller.dart';
import '../core/utils/log/app_logger.dart';
import '../di/di.dart';
import '../features/musics/presentation/bloc/bloc.dart';
import '../gen/i18n/translations.g.dart';
import 'app_bloc/app_bloc.dart';
import 'base/page/base_page_bloc_state.dart';
import 'global_notify_bloc/global_notify_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BasePageBlocState<MyApp, AppBloc> {
  final controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    bloc.add(AppInitstate());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String lang = LocalStorage.getStringValue(SharedPreferenceKeys.languages);
      if (lang == "en") {
        LocaleSettings.instance.setLocale(AppLocale.en);
      } else {
        LocaleSettings.instance.setLocale(AppLocale.km);
      }
      AppLocaleUtils.supportedLocales.log();
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt.get<MusicsBloc>()),
        BlocProvider(create: (_) => getIt.get<ThemeController>()),
        BlocProvider<GlobalNotifyBloc>.value(
          value: getIt.get<GlobalNotifyBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeController, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior(),
            routerConfig: getIt.get<AppRouter>().config(),
            theme: context.read<ThemeController>().lightTheme,
            darkTheme: context.read<ThemeController>().darkTheme,
            themeMode: themeMode,
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            builder: (_, child) => child!,
          );
        },
      ),
    );
  }
}
