import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../bloc/band_active_bloc.dart';

@RoutePage()
class bandActivePage extends StatefulWidget {
  const bandActivePage({super.key});

  @override
  State<bandActivePage> createState() => _bandPageState();
}

class _bandPageState extends BasePageBlocState<bandActivePage, bandActiveBloc> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    bloc.add(InitPageEvent());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<bandActiveBloc, bandActiveState>(
      builder: (context, state) {
        if (state.isLoading && state.band.isEmpty) {
          return Center(
            child: CustomLoading(),
          );
        }
        if (state.band.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(t.band.noDateMes),
              kPadding.gap,
              MoonButton(
                buttonSize: MoonButtonSize.sm,
                backgroundColor: context.moonColors!.piccolo,
                label: Text(
                  t.common.exploreNnow,
                  style: context.moonTypography!.heading.text14
                      .copyWith(color: Colors.white),
                ),
                onTap: () {
                  appRoute.push(AppRouteInfo.resultSearch("", 2));
                },
              )
            ],
          );
        }
        return AppSmartRefreshScrollView(
          enableLoadMore: state.isMorePage,
          onRefresh: () async {
            bloc.add(RefreshPageEvent());
          },
          onLoadMore: () async {
            bloc.add(InitPageEvent());
          },
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.band.length,
            itemBuilder: (context, index) {
              final band = state.band[index];
              return MoonMenuItem(
                // menuItemPadding: EdgeInsets.symmetric(v),
                onTap: () {
                  bloc.add(ClickbandEvent(index));
                },
                leading: CustomAvatar(
                  name: band.name,
                  high: 50,
                  width: 50,
                  image: band.cover,
                ),
                label: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      band.name,
                      style: context.moonTypography!.heading.text14,
                    ),
                    Text(
                      "${band.member} ${t.common.member}",
                      style: context.moonTypography!.body.text14
                          .copyWith(color: context.moonColors!.trunks),
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      band.updatedAt,
                      style: context.moonTypography!.body.text12
                          .copyWith(color: context.moonColors!.trunks),
                    ),
                    if (band.unread > 0)
                      Container(
                        margin: EdgeInsets.only(top: kPadding / 2),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            color: context.moonColors!.chichi,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "${band.unread}",
                          style: context.moonTypography!.body.text12
                              .copyWith(color: Colors.white),
                        ),
                      )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
