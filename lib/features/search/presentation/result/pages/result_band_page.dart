import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/widgets/custom_avata.dart';
import '../../../../../gen/i18n/translations.g.dart';
import '../../../../../shared/widgets/app_divider.dart';
import '../../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../../band/presentation/widgets/search_band_simmer_widget.dart';
import '../../../../band/presentation/widgets/status_band_widget.dart';
import '../bloc/bloc/result_band_bloc.dart';

class ResultbandPage extends StatefulWidget {
  final String text;
  const ResultbandPage({super.key, required this.text});

  @override
  State<ResultbandPage> createState() => _ResultbandPageState();
}

class _ResultbandPageState
    extends BasePageBlocState<ResultbandPage, ResultbandBloc> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    bloc.add(InitPage(widget.text));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ResultbandBloc, ResultBandState>(
      builder: (context, state) {
        if (state.isLoading && state.band.isEmpty) {
          return SingleChildScrollView(child: SearchbandItemShimmerWidget());
        }
        // if (state.band.isEmpty) {
        //   return Center(
        //     child: CustomEmptyData(),
        //   );
        // }
        return AppSmartRefreshScrollView(
          onRefresh: () async {
            bloc.add(RefreshPage(widget.text));
          },
          onLoadMore: () async {
            bloc.add(InitPage(widget.text));
          },
          child: widget.text == ""
              ? Column(
                  children: [
                    if (state.recentSearch.isNotEmpty)
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 4),
                          color: context.moonColors!.gohan,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.common.recentSearch,
                                style: context.moonTypography!.body.text14
                                    .copyWith(
                                        color: context.moonColors!.trunks),
                              ),
                              GestureDetector(
                                onTap: () {
                                  bloc.add(RemoveAll());
                                },
                                child: Text(
                                  t.common.delete,
                                  style: context.moonTypography!.body.text14
                                      .copyWith(
                                          color: context.moonColors!.trunks),
                                ),
                              ),
                            ],
                          )),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.recentSearch.length,
                        itemBuilder: (context, index) {
                          final band = state.recentSearch[index];
                          return Dismissible(
                            background: Container(
                                color: context.moonColors!.jiren,
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  t.common.delete,
                                  style: context.moonTypography!.body.text14
                                      .copyWith(color: Colors.white),
                                )),
                            key: Key("$band"),
                            direction: DismissDirection
                                .endToStart, // 👈 Only allow swipe left
                            onDismissed: (direction) {
                              bloc.add(RemoveIndex(index));
                            },
                            child: MoonMenuItem(
                              menuItemCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              onTap: () {
                                bloc.add(Clickband(band));
                              },
                              leading: CustomAvatar(
                                high: 50,
                                width: 50,
                                image: band.cover,
                              ),
                              label: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    band.name,
                                    style: context
                                        .moonTypography!.heading.text18
                                        .copyWith(),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        MoonIcons.maps_world_16_light,
                                        color: context.moonColors!.trunks,
                                        size: 20,
                                      ),
                                      Text(
                                          band.isPublic
                                              ? t.band.privateAudienceTitle
                                              : t.band.publicAudienceTitle,
                                          style: context
                                              .moonTypography!.body.text14
                                              .copyWith(
                                                  color: context
                                                      .moonColors!.trunks)),
                                      Text("  ${band.member}",
                                          style: context
                                              .moonTypography!.heading.text14),
                                      Text(
                                        " ${t.common.member}  .  ${band.question} ${t.common.question}",
                                        style: context
                                            .moonTypography!.body.text14
                                            .copyWith(
                                                color:
                                                    context.moonColors!.trunks),
                                      ),
                                      Text(
                                        "  .  ${band.discussion} ${t.common.discussion}",
                                        style: context
                                            .moonTypography!.body.text14
                                            .copyWith(
                                                color:
                                                    context.moonColors!.trunks),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            AppDivider.medium(),
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => AppDivider.medium(),
                  padding: EdgeInsets.zero,
                  itemCount: state.band.length,
                  itemBuilder: (context, index) {
                    final band = state.band[index];
                    return MoonMenuItem(
                      menuItemCrossAxisAlignment: CrossAxisAlignment.start,
                      onTap: () {
                        bloc.add(Clickband(band));
                      },
                      leading: CustomAvatar(
                        high: 50,
                        width: 50,
                        image: band.cover,
                        name: band.name,
                      ),
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            band.name,
                            style: context.moonTypography!.heading.text18,
                          ),
                          if (band.description != "")
                            Text(
                              band.description,
                              style: context.moonTypography!.body.text14
                                  .copyWith(color: context.moonColors!.trunks),
                            ),
                          kPadding.gap,
                          Row(
                            children: [
                              Icon(
                                MoonIcons.maps_world_16_light,
                                color: context.moonColors!.trunks,
                                size: 18,
                              ),
                              Text(
                                  band.isPublic
                                      ? t.band.privateAudienceTitle
                                      : t.band.publicAudienceTitle,
                                  style: context.moonTypography!.body.text14
                                      .copyWith(
                                          color: context.moonColors!.trunks)),
                            ],
                          ),
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
                        ],
                      ),
                      trailing: StatusbandWidget(
                        band: band,
                        ontap: () {
                          if (band.isPublic) {
                            if (band.status == '') {
                              bloc.add(ClickRequest(index));
                            } else {
                              bloc.add(ClickCancelRequest(index));
                            }
                          } else {
                            if (band.status == '') {
                              bloc.add(ClickJoin(index));
                            } else {
                              bloc.add(ClickLeave(index));
                            }
                          }
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
