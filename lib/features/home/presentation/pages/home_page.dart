import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../data/models/filter_entity.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../bottom_navigationbar/bloc/scaffold_with_navbar_bloc.dart';
import '../bloc/bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageBlocState<HomePage, HomeBloc>
    with TickerProviderStateMixin {
  @override
  void initState() {
    _scaffoldWithNavbarBloc = BlocProvider.of<ScaffoldWithNavbarBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldWithNavbarBloc.scrollController.dispose();
    super.dispose();
  }

  late ScaffoldWithNavbarBloc _scaffoldWithNavbarBloc;
  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            top: _scaffoldWithNavbarBloc.state.isShowButton,
            child: Column(
              children: [
                if (_scaffoldWithNavbarBloc.state.isShowButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: Row(
                      children: [
                        Text(
                          t.common.appname,
                          style: context.moonTypography!.heading.text20
                              .copyWith(color: context.moonColors!.piccolo),
                        ),
                        Spacer(),
                        Stack(
                          children: [
                            MoonButton(
                              onTap: () async {
                                bloc.add(ClickNotification());
                              },
                              label:
                                  Icon(MoonIcons.notifications_bell_24_regular),
                            ),
                            if (state.filter.activeFilterCount != 0)
                              Positioned(
                                right: kPadding / 2,
                                child: ClipOval(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 15,
                                    width: 15,
                                    color: Colors.red,
                                    child: Text(
                                      "${state.filter.activeFilterCount}",
                                      style: context
                                          .moonTypography!.heading.text10
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                AppDivider(),
                GestureDetector(
                  onTap: () {
                    appRoute.push(AppRouteInfo.testHome());
                  },
                  child: Container(
                    padding: EdgeInsets.all(kPadding2),
                    child: Text("Go to test "),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
