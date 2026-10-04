import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import 'alert/delete_other_session_alert.dart';
import 'bloc/active_session_bloc.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_refresh_indicator.dart';
import 'package:moon_design/moon_design.dart';

import '../../../gen/i18n/translations.g.dart';

@RoutePage()
class ActiveSessionPage extends StatefulWidget {
  const ActiveSessionPage({super.key});

  @override
  State<ActiveSessionPage> createState() => _ActiveSessionPageState();
}

class _ActiveSessionPageState
    extends BasePageBlocState<ActiveSessionPage, ActiveSessionBloc> {
  @override
  void initState() {
    bloc.add(GetActiveSession());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t.activeSession.title)),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kPadding2),
          child: BlocBuilder<ActiveSessionBloc, ActiveSessionState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CustomLoading());
              }
              return AppSmartRefreshScrollView(
                onRefresh: () async {
                  bloc.add(GetActiveSession());
                },
                enableLoadMore: false,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kPadding2, bottom: kPadding),
                        child: Text(t.activeSession.thisDevice),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: context.moonColors!.beerus.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(kRadius2)),
                        child: Column(
                          children: [
                            MoonMenuItem(
                              onTap: () {},
                              leading: Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      color: context.moonColors!.piccolo,
                                      borderRadius:
                                          BorderRadius.circular(kRadius2)),
                                  child: const Icon(
                                    MoonIcons.devices_smartphone_24_light,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                              label: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${state.yourDevice!.model}",
                                      style: context
                                          .moonTypography!.heading.text16),
                                  const Gap(kPadding / 2),
                                  Text(
                                    "${state.yourDevice!.city} , ${state.yourDevice!.country} . ${state.yourDevice!.createdAt}",
                                    style: context.moonTypography!.body.text14
                                        .copyWith(
                                            color: context.moonColors!.trunks),
                                  ),
                                  kPadding.gap,
                                  const AppDivider.large()
                                ],
                              ),
                            ),
                            if (state.activeSession.isNotEmpty)
                              GestureDetector(
                                onTap: () async {
                                  bool done =
                                      await DeleteOtherSessionAlert.show(
                                          context);
                                  if (done) {
                                    bloc.add(DeleteOtherActiveSession());
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding2),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.back_hand_outlined,
                                          color: context.moonColors!.jiren,
                                          size: 18,
                                        ),
                                      ),
                                      kPadding.gap,
                                      Text(
                                        t.activeSession.terminateAllother,
                                        style: context
                                            .moonTypography!.body.text14
                                            .copyWith(
                                          color: context.moonColors!.jiren,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            kPadding.gap
                          ],
                        ),
                      ),
                      if (state.activeSession.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: kPadding2,
                                  bottom: kPadding,
                                  top: kPadding2),
                              child: Text(t.activeSession.title),
                            ),
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kRadius2),
                                color:
                                    context.moonColors!.beerus.withOpacity(0.3),
                              ),
                              child: Column(
                                children: [
                                  ...List.generate(state.activeSession.length,
                                      (index) {
                                    final active = state.activeSession[index];
                                    return Dismissible(
                                      key: Key("$active"),
                                      background: Container(
                                          color: context.moonColors!.jiren,
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            t.activeSession.terminate,
                                            style: context
                                                .moonTypography!.body.text14
                                                .copyWith(color: Colors.white),
                                          )),
                                      direction: DismissDirection
                                          .endToStart, // 👈 Only allow swipe left
                                      onDismissed: (direction) {
                                        bloc.add(DeleteOneActiveSession(index));
                                      },
                                      child: MoonMenuItem(
                                          onTap: () {},
                                          leading: Container(
                                              padding: EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                  color: context
                                                      .moonColors!.piccolo,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kRadius2)),
                                              child: Icon(
                                                  MoonIcons
                                                      .devices_smartphone_24_light,
                                                  color: Colors.white,
                                                  size: 30)),
                                          label: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${active.model}",
                                                style: context.moonTypography!
                                                    .heading.text16,
                                              ),
                                              const Gap(kPadding / 2),
                                              Text(
                                                "${active.city} , ${active.country} . ${active.createdAt}",
                                                style: context
                                                    .moonTypography!.body.text14
                                                    .copyWith(
                                                        color: context
                                                            .moonColors!
                                                            .trunks),
                                              ),
                                              kPadding.gap,
                                              const AppDivider.large()
                                            ],
                                          )),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
