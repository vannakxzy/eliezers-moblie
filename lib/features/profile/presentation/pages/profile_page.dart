import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  final int userId;
  const ProfilePage({
    super.key,
    required this.userId,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageBlocState<ProfilePage, ProfileBloc> {
  @override
  void initState() {
    bloc.add(InitPageEvent(widget.userId));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          decoration: KDecoration,
          child: SafeArea(
            child: AppSmartRefreshScrollView(
              onRefresh: () async {
                bloc.add(InitPageEvent(widget.userId));
              },
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: MoonButton.icon(
                      onTap: () {
                        appRoute.push(AppRouteInfo.setting());
                      },
                      icon: Icon(MoonIcons.generic_settings_24_regular),
                    ),
                  ),
                  kPadding2.gap,
                  MoonAvatar(
                    height: MediaQuery.sizeOf(context).width / 3,
                    width: MediaQuery.sizeOf(context).width / 3,
                    borderRadius: BorderRadius.circular(kRadius),
                    backgroundImage:
                        CachedNetworkImageProvider(state.profileEntity.profile),
                  ),
                  kPadding2.gap,
                  Text(
                    state.profileEntity.name.toUpperCase(),
                    style: context.moonTypography!.heading.text24,
                  ),
                  Text(
                    state.profileEntity.email,
                    style: context.moonTypography!.body.text18,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
