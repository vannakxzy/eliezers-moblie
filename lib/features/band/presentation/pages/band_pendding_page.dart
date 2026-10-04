import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../bloc/bloc/band_pendding_bloc.dart';

@RoutePage()
class bandPenddingPage extends StatefulWidget {
  const bandPenddingPage({super.key});

  @override
  State<bandPenddingPage> createState() => _bandPageState();
}

class _bandPageState
    extends BasePageBlocState<bandPenddingPage, bandPenddingBloc> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    bloc.add(InitPageEvent());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<bandPenddingBloc, bandPenddingState>(
      builder: (context, state) {
        if (state.isLoading && state.band.isEmpty) {
          return Center(
            child: CustomLoading(),
          );
        }

        return AppSmartRefreshScrollView(
          enableLoadMore: state.isMorePage,
          onRefresh: () async {
            bloc.add(RefreshPage());
          },
          onLoadMore: () async {
            bloc.add(InitPageEvent());
          },
          child: state.band.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(MoonIcons.mail_send_24_regular),
                    // kPadding.gap,
                    Text(t.band.noNewSednRequest),
                    // MoonButton(
                    //   buttonSize: MoonButtonSize.sm,
                    //   backgroundColor: context.moonColors!.piccolo,
                    //   label: Text(
                    //     t.common.exploreNnow,
                    //     style: context.moonTypography!.heading.text14
                    //         .copyWith(color: Colors.white),
                    //   ),
                    //   onTap: () {
                    //     appRoute.push(AppRouteInfo.resultSearch("", 2));
                    //   },
                    // )
                  ],
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.band.length,
                  itemBuilder: (context, index) {
                    final band = state.band[index];
                    return MoonMenuItem(
                      menuItemCrossAxisAlignment: CrossAxisAlignment.start,
                      onTap: () {
                        bloc.add(Clickband(index));
                      },
                      leading: CustomAvatar(
                        high: 60,
                        width: 60,
                        image: band.cover,
                      ),
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            band.name,
                            style: context.moonTypography!.heading.text16,
                          ),
                          if (band.description != "")
                            Text(
                              band.description,
                              style: context.moonTypography!.body.text14
                                  .copyWith(color: context.moonColors!.trunks),
                            ),
                          Text(
                            band.createdAt,
                            style: context.moonTypography!.body.text14
                                .copyWith(color: context.moonColors!.trunks),
                          ),
                          kPadding.gap,
                          Row(
                            children: [
                              Text(
                                "${band.member} ${t.common.member}",
                                style: context.moonTypography!.body.text14
                                    .copyWith(
                                        color: context.moonColors!.trunks),
                              ),
                              Text(
                                "  .  ${band.question} ${t.common.question}",
                                style: context.moonTypography!.body.text14
                                    .copyWith(
                                        color: context.moonColors!.trunks),
                              ),
                              Text(
                                "  .  ${band.discussion} ${t.common.discussion}",
                                style: context.moonTypography!.body.text14
                                    .copyWith(
                                        color: context.moonColors!.trunks),
                              ),
                            ],
                          ),

                          kPadding.gap,
                          MoonButton(
                            isFullWidth: true,
                            buttonSize: MoonButtonSize.sm,
                            backgroundColor: context.moonColors!.beerus,
                            label: Text(
                              t.common.cancel,
                              style: context.moonTypography!.heading.text16
                                  .copyWith(color: context.moonColors!.trunks),
                            ),
                            onTap: () {
                              debugPrint("khmer sl khmer ");
                              bloc.add(ClickCancel(index));
                            },
                          ),
                          kPadding.gap,
                          AppDivider.large(),
                          // kPadding.gap,
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
