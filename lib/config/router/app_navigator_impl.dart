import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/object_utils.dart';
import 'package:moon_design/moon_design.dart';

import '../../app/base/navigation/app_navigator.dart';
import '../../core/constants/log_constant.dart';
import '../../core/utils/log/log_utils.dart';
import '../../features/bottom_navigationbar/tab/bottom_tab.dart';
import 'app_router.dart';
import 'page_route/app_route_info.dart';
import 'page_route/app_route_info_mapper.dart';
import 'popup_route/app_popup_info.dart';
import 'popup_route/app_popup_info_mapper.dart';

@LazySingleton(as: IAppNavigator)
class AppNavigatorImpl extends IAppNavigator with LogMixin {
  AppNavigatorImpl(
    this._appRouter,
    this._appPopupInfoMapper,
    this._appRouteInfoMapper,
  );

  final tabRoutes = BottomTab.values.map((e) => e.route).toList();

  TabsRouter? tabsRouter;

  final AppRouter _appRouter;
  final BasePopupInfoMapper _appPopupInfoMapper;
  final BaseRouteInfoMapper _appRouteInfoMapper;
  final _shownPopups = <AppPopupInfo, Completer<dynamic>>{};

  StackRouter? get _currentTabRouter =>
      tabsRouter?.stackRouterOfIndex(currentBottomTab);

  StackRouter get _currentTabRouterOrRootRouter =>
      _currentTabRouter ?? _appRouter;

  @override
  m.BuildContext get context => _rootRouterContext;

  m.BuildContext get _rootRouterContext =>
      _appRouter.navigatorKey.currentContext!;

  m.BuildContext? get _currentTabRouterContext =>
      _currentTabRouter?.navigatorKey.currentContext;

  m.BuildContext get _currentTabContextOrRootContext =>
      _currentTabRouterContext ?? _rootRouterContext;

  @override
  int get currentBottomTab {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    return tabsRouter?.activeIndex ?? 0;
  }

  @override
  bool get canPopSelfOrChildren => _appRouter.canPop();

  @override
  String getCurrentRouteName({bool useRootNavigator = false}) =>
      AutoRouter.of(useRootNavigator
              ? _rootRouterContext
              : _currentTabContextOrRootContext)
          .current
          .name;

  @override
  void popUntilRootOfCurrentBottomTab() {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    if (_currentTabRouter?.canPop() == true) {
      if (LogConstants.enableNavigatorObserverLog) {
        logD('popUntilRootOfCurrentBottomTab');
      }
      _currentTabRouter?.popUntilRoot();
    }
  }

  @override
  void navigateToBottomTab(int index, {bool notify = true}) {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    if (LogConstants.enableNavigatorObserverLog) {
      logD('navigateToBottomTab with index = $index, notify = $notify');
    }
    tabsRouter?.setActiveIndex(index, notify: notify);
  }

  @override
  Future<T?> push<T extends Object?>(AppRouteInfo appRouteInfo) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD('push $appRouteInfo');
    }

    return _appRouter.push<T>(_appRouteInfoMapper.map(appRouteInfo));
  }

  @override
  Future<void> pushAll(List<AppRouteInfo> listAppRouteInfo) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD('pushAll $listAppRouteInfo');
    }

    return _appRouter.pushAll(_appRouteInfoMapper.mapList(listAppRouteInfo));
  }

  @override
  Future<T?> replace<T extends Object?>(AppRouteInfo appRouteInfo) {
    _shownPopups.clear();
    if (LogConstants.enableNavigatorObserverLog) {
      logD('replace by $appRouteInfo');
    }

    return _appRouter.replace<T>(_appRouteInfoMapper.map(appRouteInfo));
  }

  @override
  Future<void> replaceAll(List<AppRouteInfo> listAppRouteInfo) {
    _shownPopups.clear();
    if (LogConstants.enableNavigatorObserverLog) {
      logD('replaceAll by $listAppRouteInfo');
    }

    return _appRouter.replaceAll(_appRouteInfoMapper.mapList(listAppRouteInfo));
  }

  @override
  Future<bool> pop<T extends Object?>(
      {T? result, bool useRootNavigator = false}) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD('pop with result = $result, useRootNav = $useRootNavigator');
    }

    return useRootNavigator
        ? _appRouter.maybePop<T>(result)
        : _currentTabRouterOrRootRouter.maybePop<T>(result);
  }

  @override
  Future<T?> popAndPush<T extends Object?, R extends Object?>(
    AppRouteInfo appRouteInfo, {
    R? result,
    bool useRootNavigator = false,
  }) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD(
          'popAndPush $appRouteInfo with result = $result, useRootNav = $useRootNavigator');
    }

    return useRootNavigator
        ? _appRouter.popAndPush<T, R>(_appRouteInfoMapper.map(appRouteInfo),
            result: result)
        : _currentTabRouterOrRootRouter.popAndPush<T, R>(
            _appRouteInfoMapper.map(appRouteInfo),
            result: result,
          );
  }

  @override
  void popUntilRoot({bool useRootNavigator = false}) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD('popUntilRoot, useRootNav = $useRootNavigator');
    }

    useRootNavigator
        ? _appRouter.popUntilRoot()
        : _currentTabRouterOrRootRouter.popUntilRoot();
  }

  @override
  void popUntilRouteName(String routeName) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD('popUntilRouteName $routeName');
    }

    _appRouter.popUntilRouteWithName(routeName);
  }

  @override
  bool removeUntilRouteName(String routeName) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD('removeUntilRouteName $routeName');
    }

    return _appRouter.removeUntil((route) => route.name == routeName);
  }

  @override
  bool removeAllRoutesWithName(String routeName) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD('removeAllRoutesWithName $routeName');
    }

    return _appRouter.removeWhere((route) => route.name == routeName);
  }

  @override
  Future<void> popAndPushAll(List<AppRouteInfo> listAppRouteInfo,
      {bool useRootNavigator = false}) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD('popAndPushAll $listAppRouteInfo, useRootNav = $useRootNavigator');
    }

    return useRootNavigator
        ? _appRouter
            .popAndPushAll(_appRouteInfoMapper.mapList(listAppRouteInfo))
        : _currentTabRouterOrRootRouter
            .popAndPushAll(_appRouteInfoMapper.mapList(listAppRouteInfo));
  }

  @override
  bool removeLast() {
    if (LogConstants.enableNavigatorObserverLog) {
      logD('removeLast');
    }

    return _appRouter.removeLast();
  }

  @override
  Future<T?> showDialog<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    bool barrierDismissible = true,
    bool useSafeArea = false,
    bool useRootNavigator = true,
  }) {
    if (_shownPopups.containsKey(appPopupInfo)) {
      logD('Dialog $appPopupInfo already shown');

      return _shownPopups[appPopupInfo]!.future.safeCast();
    }
    _shownPopups[appPopupInfo] = Completer<T?>();

    return showMoonModal<T>(
      context: useRootNavigator
          ? _rootRouterContext
          : _currentTabContextOrRootContext,
      builder: (_) => m.PopScope(
        canPop: true,
        onPopInvokedWithResult: (_, __) async {
          logD('Dialog $appPopupInfo dismissed');
          _shownPopups.remove(appPopupInfo);

          return;
        },
        child: _appPopupInfoMapper.map(appPopupInfo, this),
      ),
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
    )..then((value) => _shownPopups.remove(appPopupInfo));
  }

  @override
  Future<T?> showGeneralDialog<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    Duration transitionDuration =
        DurationConstants.defaultGeneralDialogTransitionDuration,
    m.Widget Function(
            m.BuildContext, m.Animation<double>, m.Animation<double>, m.Widget)?
        transitionBuilder,
    m.Color barrierColor = const m.Color(0x80000000),
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) {
    if (_shownPopups.containsKey(appPopupInfo)) {
      logD('Dialog $appPopupInfo already shown');

      return _shownPopups[appPopupInfo]!.future.safeCast();
    }
    _shownPopups[appPopupInfo] = Completer<T?>();

    return m.showGeneralDialog<T>(
      context: useRootNavigator
          ? _rootRouterContext
          : _currentTabContextOrRootContext,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      pageBuilder: (
        m.BuildContext context,
        m.Animation<double> animation1,
        m.Animation<double> animation2,
      ) =>
          m.PopScope(
        // onWillPop: () async {
        //   logD('Dialog $appPopupInfo dismissed');
        //   _shownPopups.remove(appPopupInfo);

        //   return Future.value(true);
        // },
        child: _appPopupInfoMapper.map(appPopupInfo, this),
      ),
      transitionBuilder: transitionBuilder,
      transitionDuration: transitionDuration,
    );
  }

  @override
  Future<T?> showModalBottomSheet<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useSafeArea = false,
    m.Color barrierColor = m.Colors.black54,
    m.Color? backgroundColor,
  }) {
    if (LogConstants.enableNavigatorObserverLog) {
      logD(
          'showModalBottomSheet $appPopupInfo, useRootNav = $useRootNavigator');
    }

    return showMoonModalBottomSheet<T>(
      context: useRootNavigator
          ? _rootRouterContext
          : _currentTabContextOrRootContext,
      builder: (_) => _appPopupInfoMapper.map(appPopupInfo, this),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      // useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      // isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
    );
  }

  @override
  void showErrorSnackBar(
    String message,
  ) {
    _showSnackBar(
      message,
      SnackBarType.error,
    );
  }

  @override
  void showSuccessSnackBar(String message) {
    _showSnackBar(
      message,
      SnackBarType.success,
    );
  }

  @override
  void showInfoSnackBar(String message) {
    _showSnackBar(
      message,
      SnackBarType.info,
    );
  }

  void _showSnackBar(String message, SnackBarType type) {
    MoonToast.show(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(color: type.color),
        color: type.color2,
      ),
      context,
      label: m.Text(message),
      // leading: m.Icon(
      //   type.icon,
      //   color: type.color,
      //   size: 24,
      // ),
      backgroundColor: const Color(0x0000ffff),
      margin: const EdgeInsets.all(kPadding),
      variant: MoonToastVariant.original,
      toastAlignment: m.Alignment.topCenter,
    );
  }
}

enum SnackBarType {
  info,
  error,
  success;

  m.Color get color {
    switch (this) {
      case SnackBarType.info:
        return m.Colors.blue;
      case SnackBarType.error:
        return m.Colors.red;
      case SnackBarType.success:
        return m.Colors.green;
    }
  }

  m.Color get color2 {
    switch (this) {
      case SnackBarType.info:
        return m.Colors.blue.shade100;
      case SnackBarType.error:
        return m.Colors.red.shade100;
      case SnackBarType.success:
        return m.Colors.green.shade100;
    }
  }

  // m.Color get backgroundColor {
  //   switch (this) {
  //     case SnackBarType.info:
  //       return m.Colors.blue;
  //     case SnackBarType.error:
  //       return m.Colors.red;
  //     case SnackBarType.success:
  //       return m.Colors.green;
  //   }
  // }

  m.IconData get icon {
    switch (this) {
      case SnackBarType.info:
        return m.Icons.info_outline;
      case SnackBarType.error:
        return m.Icons.error_outline;
      case SnackBarType.success:
        return m.Icons.check_circle_outline_outlined;
    }
  }
}
