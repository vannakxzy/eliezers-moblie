import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moon_design/moon_design.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../config/router/app_navigator_impl.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helper/local_data/storge_local.dart';
import '../bloc/scaffold_with_navbar_bloc.dart';

import '../controller/scroll_visibility_controller.dart';
import '../tab/bottom_tab.dart';
import '../widgets/tab_bar_item.dart';

final homeKey = GlobalKey<ScaffoldState>();

@RoutePage()
class ScaffoldWithNavBarScreen extends StatefulWidget {
  final Widget? child;
  const ScaffoldWithNavBarScreen({super.key, this.child});

  @override
  State<ScaffoldWithNavBarScreen> createState() =>
      _ScaffoldWithNavBarScreenState();
}

class _ScaffoldWithNavBarScreenState extends BasePageBlocState<
    ScaffoldWithNavBarScreen, ScaffoldWithNavbarBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ScaffoldWithNavbarBloc, ScaffoldWithNavbarState>(
      builder: (_, state) {
        return SafeArea(
          child: AutoTabsScaffold(
            transitionBuilder: (context, child, animation) => child,
            // backgroundColor: context.moonColors!.goku,
            routes: (appRoute as AppNavigatorImpl).tabRoutes,
            resizeToAvoidBottomInset: true,
            bottomNavigationBuilder: (context, tabsRouter) {
              (appRoute as AppNavigatorImpl).tabsRouter = tabsRouter;
          
              return ValueListenableBuilder<bool>(
                valueListenable: ScrollVisibilityController.showBottomNav,
                builder: (context, show, child) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: show ? kBottomNavigationBarHeight : 0,
                    child: show
                        ? SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: context.moonColors!.beerus,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              width: context.width,
                              child: SafeArea(
                                top: false,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: BottomTab.values.map((e) {
                                    return Expanded(
                                      child: TabBarItem(
                                        bottomTab: e,
                                        onTap: () {
                                          _onNavigate(e, tabsRouter);
                                        },
                                        tabsRouter: tabsRouter,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _onNavigate(BottomTab bottomTab, TabsRouter tabsRouter) {
    final tabIndex = bottomTab.index;
    final token = LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);
    if (bottomTab == BottomTab.band &&
        tabsRouter.activeIndex == bottomTab.index) {
      bloc.add(PressedHomeButtonEvent());
    }
    tabsRouter.setActiveIndex(tabIndex);
   
  }
}
