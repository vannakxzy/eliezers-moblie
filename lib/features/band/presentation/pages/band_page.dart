import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../bloc/bloc.dart';
import '../widgets/band_widget.dart';

@RoutePage()
class bandPage extends StatefulWidget {
  const bandPage({super.key});

  @override
  State<bandPage> createState() => _bandPageState();
}

class _bandPageState extends BasePageBlocState<bandPage, bandBloc> {
  @override
  void initState() {
    bloc.add(InitPage(1));

    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<bandBloc, BandState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Row(children: [
                kPadding.gap,
                Text(t.band.title,
                    style: context.moonTypography!.heading.text20),
                Spacer(),
                // MoonButton(
                //   leading: Icon(MoonIcons.generic_search_24_regular),
                //   onTap: () {
                //     appRoute.push(AppRouteInfo.resultSearch('', 2));
                //   },
                // ),
                MoonButton(
                  onTap: () {
                    bloc.add(ClickCreateband());
                  },
                  leading: Icon(
                    MoonIcons.controls_plus_24_regular,
                  ),
                ),
              ]),
              Text("${state.band.length}"),
              Expanded(
                child: Container(
                  child: state.isLoading && state.band.isEmpty
                      ? Center(
                          //  child: MoonC,
                          child: CircularProgressIndicator(),
                        )
                      : state.band.isEmpty
                          ? const Center(child: SizedBox())
                          : AppSmartRefreshScrollView(
                              enableLoadMore: state.isMorePage,
                              onLoadMore: () async =>
                                  bloc.add(InitPage(state.page)),
                              onRefresh: () async {
                                bloc.add(ClickRefreshPage(1));
                              },
                              child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final band = state.band[index];
                                    return BandWidget(
                                      entity: band,
                                      clickBand: () {
                                        bloc.add(Clickband(index));
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Gap(kPadding),
                                  itemCount: state.band.length),
                            ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
