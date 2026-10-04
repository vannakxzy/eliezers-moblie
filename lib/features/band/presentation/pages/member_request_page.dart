import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../bloc/bloc/member_request_bloc.dart';

@RoutePage()
class MemberRequestPage extends StatefulWidget {
  const MemberRequestPage({super.key});

  @override
  State<MemberRequestPage> createState() => _bandPageState();
}

class _bandPageState
    extends BasePageBlocState<MemberRequestPage, MemberRequestBloc> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    bloc.add(InitPage());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<MemberRequestBloc, MemberRequestState>(
      builder: (context, state) {
        if (state.isLoading && state.bandMember.isEmpty) {
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
            bloc.add(InitPage());
          },
          child: !state.bandMember.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(MoonIcons.mail_send_24_regular),
                    kPadding.gap,
                    Text(t.band.noNewRequest),
                  ],
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.bandMember.length,
                  itemBuilder: (context, index) {
                    final bandMember = state.bandMember[index];
                    return MoonMenuItem(
                      menuItemCrossAxisAlignment: CrossAxisAlignment.start,
                      onTap: () {
                        bloc.add(Clickband(bandMember.band));
                      },
                      leading: GestureDetector(
                        onTap: () {
                          bloc.add(ClickProfile(bandMember.user.id));
                        },
                        child: CustomAvatar(
                          high: 50,
                          width: 50,
                          name: bandMember.user.name,
                          image: bandMember.user.profile,
                        ),
                      ),
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "${bandMember.user.name}  ",
                              style: context.moonTypography!.heading.text14
                                  .copyWith(color: context.moonColors!.bulma),
                            ),
                            TextSpan(
                              text: t.band.requestMes,
                              style: context.moonTypography!.body.text14
                                  .copyWith(color: context.moonColors!.trunks),
                            ),
                            TextSpan(
                              text: "   >> ${bandMember.band.name} <<",
                              style: context.moonTypography!.heading.text14
                                  .copyWith(color: context.moonColors!.bulma),
                            ),
                          ])),
                          Text(
                            bandMember.createAt,
                            style: context.moonTypography!.body.text14
                                .copyWith(color: context.moonColors!.trunks),
                          ),
                          Gap(kPadding / 2),
                          Row(
                            children: [
                              MoonButton(
                                buttonSize: MoonButtonSize.sm,
                                backgroundColor: context.moonColors!.piccolo,
                                label: Text(
                                  t.common.accept,
                                  style: context.moonTypography!.heading.text16
                                      .copyWith(color: Colors.white),
                                ),
                                onTap: () {
                                  bloc.add(ClickApprove(index));
                                },
                              ),
                              kPadding.gap,
                              MoonButton(
                                buttonSize: MoonButtonSize.sm,
                                backgroundColor: context.moonColors!.beerus,
                                label: Text(
                                  t.common.cancel,
                                  style: context.moonTypography!.heading.text16
                                      .copyWith(
                                          color: context.moonColors!.trunks),
                                ),
                                onTap: () {
                                  bloc.add(ClickDetele(index));
                                },
                              ),
                            ],
                          ),
                          kPadding.gap,
                          // AppDivider.large(),
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
