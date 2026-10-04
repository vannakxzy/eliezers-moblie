import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../bloc/bloc/drawer_home_bloc.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends BasePageBlocState<DrawerHome, DrawerHomeBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Removes border radius
      ),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
          child: Column(
            children: [
              MoonMenuItem(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(MoonIcons.generic_home_16_regular),
                label: Text(
                  t.common.home,
                  style: context.moonTypography!.body.text18
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              MoonMenuItem(
                onTap: () {
                  appRoute.push(AppRouteInfo.users());
                },
                leading: Icon(MoonIcons.generic_user_16_regular),
                label: Text(
                  t.common.user,
                  style: context.moonTypography!.body.text18
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              MoonMenuItem(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(MoonIcons.generic_tag_16_regular),
                label: Text(
                  t.common.tag,
                  style: context.moonTypography!.body.text18
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              MoonMenuItem(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(MoonIcons.generic_bookmark_16_regular),
                label: Text(
                  t.book.book,
                  style: context.moonTypography!.body.text18
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              kPadding2.gap,
              MoonMenuItem(
                onTap: () {
                  // Navigator.pop(context);
                  appRoute.push(AppRouteInfo.discussion());
                },
                leading: Icon(MoonIcons.chat_chat_16_regular),
                label: Text(
                  t.common.discussion,
                  style: context.moonTypography!.body.text18
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
