
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';

/// Modern page transition:
/// Fade + Slide + subtle Scale
Widget _pageTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  );

  final slideAnimation = Tween<Offset>(
    begin: const Offset(0.06, 0),
    end: Offset.zero,
  ).animate(curvedAnimation);

  final scaleAnimation = Tween<double>(
    begin: 0.985,
    end: 1,
  ).animate(curvedAnimation);

  return FadeTransition(
    opacity: curvedAnimation,
    child: SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: child,
      ),
    ),
  );
}

/// No animation for bottom navigation tabs.
Widget _noTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return child;
}

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
@LazySingleton()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        // Authentication
        CustomRoute(
          page: SplashRoute.page,
          initial: true,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 500,
        ),

        CustomRoute(
          page: LoginRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        CustomRoute(
          page: CreateAccountRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        CustomRoute(
          page: SecurityLoginRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        CustomRoute(
          page: VerifyEmailCreateaccountRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        // Bible
        CustomRoute(
          page: BibleBookRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        // Main navigation
        CustomRoute(
          page: ScaffoldWithNavBarRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
          children: [
            CustomRoute(
              page: EventRoute.page,
              transitionsBuilder: _noTransition,
            ),
            CustomRoute(
              page: MusicsRoute.page,
              transitionsBuilder: _noTransition,
            ),
            CustomRoute(
              page: ProfileRoute.page,
              transitionsBuilder: _noTransition,
            ),
            CustomRoute(
              page: BibleRoute.page,
              transitionsBuilder: _noTransition,
            ),
          ],
        ),

        // Event
        CustomRoute(
          page: EventDetailRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        CustomRoute(
          page: EditEventRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        CustomRoute(
          page: CreateEventRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        // Music
        CustomRoute(
          page: EditMusicRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        CustomRoute(
          page: CreateMusicRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        CustomRoute(
          page: MusicsDetailRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
        ),

        // Settings
        CustomRoute(
          page: SettingRoute.page,
          transitionsBuilder: _pageTransition,
          durationInMilliseconds: 450,
          children: [
            CustomRoute(
              page: PersonalInfoRoute.page,
              transitionsBuilder: _pageTransition,
              durationInMilliseconds: 350,
            ),
            CustomRoute(
              page: AppearanceRoute.page,
              transitionsBuilder: _pageTransition,
              durationInMilliseconds: 350,
            ),
            CustomRoute(
              page: NotificationRoute.page,
              transitionsBuilder: _pageTransition,
              durationInMilliseconds: 350,
            ),
            CustomRoute(
              page: SecurityLoginRoute.page,
              transitionsBuilder: _pageTransition,
              durationInMilliseconds: 350,
            ),
            CustomRoute(
              page: FeedbackRoute.page,
              transitionsBuilder: _pageTransition,
              durationInMilliseconds: 350,
            ),
          ],
        ),
      ];
}
