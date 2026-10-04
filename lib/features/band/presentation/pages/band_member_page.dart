import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../domain/entities/band_entity.dart';
import '../bloc/bloc/band_member_bloc.dart';

@RoutePage()
class bandMemberPage extends StatefulWidget {
  final BandEntity band;
  const bandMemberPage({super.key, required this.band});
  @override
  State<bandMemberPage> createState() => _bandMemberPageState();
}

class _bandMemberPageState
    extends BasePageBlocState<bandMemberPage, bandMemberBloc> {
  Timer? _debounce;
  @override
  void initState() {
    bloc.add(InitPage(widget.band.id));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<bandMemberBloc, bandMemberState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(state.newMember);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(t.common.member),
              actions: [
                MoonButton(
                    leading: Icon(MoonIcons.generic_plus_24_regular),
                    onTap: () {
                      bloc.add(ClickAddMember(widget.band));
                    })
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                children: [
                  MoonTextInput(
                    controller: state.textController,
                    autofocus: true,
                    backgroundColor:
                        context.moonColors!.beerus.withOpacity(0.2),
                    padding: const EdgeInsets.only(left: kPadding2),
                    height: 35,
                    borderRadius: BorderRadius.circular(333),
                    textInputSize: MoonTextInputSize.lg,
                    activeBorderColor: context.moonColors!.beerus,
                    hintText: t.search.title,
                    onChanged: (value) {
                      _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 300), () {
                        bloc.add(TextChanged(widget.band.id, value));
                      });
                    },
                    trailing: state.textSearch.isNotEmpty
                        ? MoonButton.icon(
                            padding: EdgeInsets.zero,
                            hoverEffectColor: Colors.transparent,
                            onTap: () {
                              bloc.add(ClearTextSearch());
                              bloc.add(TextChanged(widget.band.id, ''));
                            },
                            icon: Icon(Icons.clear_rounded,
                                color: context.moonColors!.trunks),
                          )
                        : const SizedBox.shrink(),
                  ),
                  kPadding.gap,
                  Expanded(
                    child: AppSmartRefreshScrollView(
                      enableLoadMore: state.isMorePage,
                      onLoadMore: () async {
                        bloc.add(InitPage(widget.band.id));
                      },
                      onRefresh: () async {
                        bloc.add(RefreshPage(widget.band.id));
                      },
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final memeber = state.member[index];
                            return Column(
                              children: [
                                AppDivider.medium(),
                                kPadding.gap,
                                Dismissible(
                                  direction: widget.band.yourRole == "owner" &&
                                          memeber.role != "owner"
                                      ? DismissDirection.endToStart
                                      : DismissDirection.none,
                                  onDismissed: (value) {
                                    bloc.add(ClickRemove(index, memeber.id));
                                  },
                                  key: Key("$memeber"),
                                  background: Container(
                                    color: AppColor.dangerColor,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding2),
                                    child: Text(
                                      t.common.remove,
                                      style: context.moonTypography!.body.text14
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  child: MoonMenuItem(
                                    menuItemPadding: EdgeInsets.zero,
                                    onTap: () {
                                      bloc.add(ClickMember(memeber.user.id));
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
                                      style: context.moonTypography!.body.text16
                                          .copyWith(
                                              color:
                                                  context.moonColors!.chichi),
                                    ),
                                  ),
                                ),
                                kPadding.gap,
                              ],
                            );
                          },
                          separatorBuilder: (_, index) => AppDivider.large(),
                          itemCount: state.member.length),
                    ),
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
