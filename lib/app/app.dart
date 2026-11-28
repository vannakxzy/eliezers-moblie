
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../config/router/app_router.dart';
import '../config/theme/theme_controller.dart';
import '../core/constants/constants.dart';
import '../core/helper/fuction.dart';
import '../core/helper/local_data/storge_local.dart';
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
  static const Color backgroundColor = Color.fromARGB(255, 23, 23, 23);

  static const SystemUiOverlayStyle systemUiStyle = SystemUiOverlayStyle(
    statusBarColor: backgroundColor,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: backgroundColor,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: backgroundColor,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
  );

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(systemUiStyle);

    bloc.add(AppInitstate());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lang = LocalStorage.getStringValue(
        SharedPreferenceKeys.languages,
      );

      if (lang == 'en') {
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
        BlocProvider(
          create: (_) => getIt.get<MusicsBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt.get<ThemeController>(),
        ),
        BlocProvider<GlobalNotifyBloc>.value(
          value: getIt.get<GlobalNotifyBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeController, ThemeMode>(
        builder: (context, themeMode) {
          final themeController = context.read<ThemeController>();

          final appTheme = themeController.darkTheme.copyWith();

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: systemUiStyle,
            child: MaterialApp.router(
              routerConfig: getIt.get<AppRouter>().config(),


              debugShowCheckedModeBanner: false,
              scrollBehavior: const MaterialScrollBehavior(),

              // routerConfig: getIt.get<AppRouter>().config(),

              theme: appTheme,
              darkTheme: appTheme,
              themeMode: themeMode,

              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,

              builder: (context, child) {
                return ColoredBox(
                  color: backgroundColor,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: unFocus,
                    child: child ?? const SizedBox.shrink(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
