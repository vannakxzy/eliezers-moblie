import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/utils/widgets/custom_avata.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_empty_data.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import '../../../shared/widgets/app_refresh_indicator.dart';
import 'bloc/hide_bloc.dart';

@RoutePage()
class HidePage extends StatefulWidget {
  const HidePage({super.key});

  @override
  State<HidePage> createState() => _HidePageState();
}

class _HidePageState extends BasePageBlocState<HidePage, HideBloc> {
  @override
  void initState() {
    bloc.add(GetHideEvent());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: t.common.hide,
        ),
        body: SafeArea(
          child: BlocBuilder<HideBloc, HideState>(
            builder: (context, state) {
              return state.isLoading && state.hides.isEmpty
                  ? const Center(
                      child: CustomLoading(),
                    )
                  : state.hides.isEmpty
                      ? const CustomEmptyData()
                      : Container(
                          padding: kScreenPadding,
                          child: AppSmartRefreshScrollView(
                            enableLoadMore: state.isMorePage,
                            onRefresh: () async => bloc.add(RefreshPage()),
                            onLoadMore: () async => bloc.add(GetHideEvent()),
                            child: ListView.builder(
                              itemCount: state.hides.length,
                              itemBuilder: (context, index) {
                                final hide = state.hides[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: context.moonColors!.beerus,
                                  ))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: kPadding, bottom: kPadding),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${hide.data!.title}",
                                                style: context
                                                    .moonTypography!.body.text14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              Text(
                                                "${hide.data!.description}",
                                                style: context
                                                    .moonTypography!.body.text12
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              Text(
                                                "${hide.data!.date}",
                                                style: context
                                                    .moonTypography!.body.text12
                                                    .copyWith(
                                                        color: context
                                                            .moonColors!.trunks,
                                                        fontWeight:
                                                            FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (hide.data!.image!.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: kPadding),
                                            child: CustomAvatar(
                                              radius: 2,
                                              image: "${hide.data!.image}",
                                            ),
                                          ),
                                        MoonTextButton(
                                          onTap: () {
                                            bloc.add(ClickUnHideEvent(index));
                                          },
                                          label: Text(
                                            t.common.unHide,
                                            style: context
                                                .moonTypography!.body.text12
                                                .copyWith(
                                                    color: context
                                                        .moonColors!.piccolo),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
            },
          ),
        ));
  }
}
