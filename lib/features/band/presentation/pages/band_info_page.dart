import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../domain/entities/band_entity.dart';
import '../../domain/entities/band_member_entity.dart';
import '../bloc/bloc/band_info_bloc.dart';

@RoutePage()
class bandInfoPage extends StatefulWidget {
  final BandEntity band;
  const bandInfoPage({super.key, required this.band});

  @override
  State<bandInfoPage> createState() => _bandInfoPageState();
}

class _bandInfoPageState extends BasePageBlocState<bandInfoPage, bandInfoBloc> {
  @override
  void initState() {
    bloc.add(InitPage(widget.band));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<bandInfoBloc, bandInfoState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: CloseButton(
                onPressed: () {
                  appRoute.pop(result: state.band);
                },
              ),
              actions: [
                if (widget.band.permission.changeInfo ||
                    widget.band.yourRole == "owner")
                  MoonButton(
                    textColor: context.moonColors!.piccolo,
                    label: Text(t.common.edit.toUpperCase()),
                    onTap: () {
                      bloc.add(ClickEdit());
                    },
                  ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: kPadding2),
              width: double.infinity,
              child: AppSmartRefreshScrollView(
                onLoadMore: () async => bloc.add(InitPage(widget.band)),
                onRefresh: () async => bloc.add(RefreshPage(widget.band)),
                enableLoadMore: state.isMorePage,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAvatar(
                        image: widget.band.cover,
                        high: 100,
                        width: 100,
                        name: widget.band.name,
                      ),
                      Text(
                        state.band.name,
                        style: context.moonTypography!.heading.text24,
                      ),
                      if (widget.band.description != "")
                        Text(
                          state.band.description,
                          style: context.moonTypography!.body.text14
                              .copyWith(color: context.moonColors!.trunks),
                        ),
                      kPadding.gap,
                      Text(
                        "${state.band.member}  ${t.common.member} , ${state.band.question}  ${t.common.question} , ${state.band.discussion}  ${t.common.discussion}",
                        style: context.moonTypography!.body.text14
                            .copyWith(color: context.moonColors!.trunks),
                      ),
                      kPadding2.gap,
                      Container(
                        clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.symmetric(
                            horizontal: kPadding2, vertical: kPadding),
                        decoration: BoxDecoration(
                          color: context.moonColors!.beerus.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(kRadius2),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (state.band.permission.addMember ||
                                state.band.yourRole == "owner")
                              MoonMenuItem(
                                onTap: () async {
                                  final List<bandMemberEntity> newMember =
                                      await appRoute.push(
                                              AppRouteInfo.addbandMember(
                                                  state.band))
                                          as List<bandMemberEntity>;
                                  bloc.add(UpdateNewMemberEvent(newMember));
                                },
                                menuItemPadding: EdgeInsets.zero,
                                leading: Icon(MoonIcons.generic_plus_32_regular,
                                    size: 28,
                                    color: context.moonColors!.piccolo),
                                label: Padding(
                                  padding:
                                      const EdgeInsets.only(left: kPadding),
                                  child: Text(
                                    t.band.addMember,
                                    style: context
                                        .moonTypography!.heading.text14
                                        .copyWith(
                                            color: context.moonColors!.piccolo),
                                  ),
                                ),
                              ),
                            ...List.generate(
                              state.member.length,
                              (index) {
                                final memeber = state.member[index];
                                return Column(
                                  children: [
                                    AppDivider.medium(),
                                    kPadding.gap,
                                    Dismissible(
                                      direction:
                                          state.band.yourRole == "owner" &&
                                                  memeber.role != "owner"
                                              ? DismissDirection.endToStart
                                              : DismissDirection.none,
                                      onDismissed: (value) {
                                        bloc.add(ClcikRemovebandMember(
                                            index, state.band.id));
                                      },
                                      key: Key("$memeber"),
                                      background: Container(
                                        color: AppColor.dangerColor,
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kPadding2),
                                        child: Text(
                                          t.common.remove,
                                          style: context
                                              .moonTypography!.body.text14
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                      child: MoonMenuItem(
                                        menuItemPadding: EdgeInsets.zero,
                                        onTap: () {
                                          bloc.add(
                                              ClickMember(memeber.user.id));
                                        },
                                        label: Row(
                                          children: [
                                            CustomAvatar(
                                                image: memeber.user.profile,
                                                name: memeber.user.name),
                                            kPadding.gap,
                                            Text(
                                              memeber.user.name,
                                              style: context
                                                  .moonTypography!.body.text16,
                                            ),
                                          ],
                                        ),
                                        trailing: Text(
                                          memeber.role == "owner" ||
                                                  memeber.role == "admin"
                                              ? memeber.role
                                              : "",
                                          style: context
                                              .moonTypography!.body.text16
                                              .copyWith(
                                                  color: context
                                                      .moonColors!.piccolo),
                                        ),
                                      ),
                                    ),
                                    kPadding.gap,
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
