import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../core/utils/widgets/custom_user_card.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../domain/entities/band_entity.dart';
import '../bloc/bloc/add_band_member_bloc.dart';

@RoutePage()
class AddbandMemberPage extends StatefulWidget {
  final BandEntity band;
  const AddbandMemberPage({super.key, required this.band});

  @override
  State<AddbandMemberPage> createState() => _AddbandMemberPageState();
}

class _AddbandMemberPageState
    extends BasePageBlocState<AddbandMemberPage, AddbandMemberBloc> {
  Timer? _debounce;

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<AddbandMemberBloc, AddbandMemberState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(t.band.addMember),
            actions: [
              MoonButton(
                buttonSize: MoonButtonSize.lg,
                borderRadius: BorderRadius.circular(kRadius2),
                textColor: state.seletedUser.isNotEmpty
                    ? context.moonColors!.piccolo
                    : context.moonColors!.trunks.withOpacity(0.6),
                label: Text(t.common.add.toUpperCase()),
                onTap: () async {
                  if (state.seletedUser.isNotEmpty) {
                    bloc.add(ClickAddMember(widget.band.id));
                    await Future.microtask(() {});
                  }
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoonTextInput(
                  controller: state.textController,
                  autofocus: true,
                  backgroundColor: context.moonColors!.beerus.withOpacity(0.2),
                  padding: const EdgeInsets.only(left: kPadding2),
                  height: 35,
                  borderRadius: BorderRadius.circular(333),
                  style: context.moonTypography!.body.text14,
                  textInputSize: MoonTextInputSize.lg,
                  activeBorderColor: context.moonColors!.beerus,
                  hintText: t.search.title,
                  onChanged: (value) {
                    _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      bloc.add(TextChanged(value, widget.band.id));
                    });
                  },
                  trailing: state.textSearch.isNotEmpty
                      ? MoonButton.icon(
                          padding: EdgeInsets.zero,
                          hoverEffectColor: Colors.transparent,
                          onTap: () {
                            bloc.add(ClearTextSearch());
                          },
                          icon: Icon(
                            Icons.clear_rounded,
                            color: context.moonColors!.trunks,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                kPadding.gap,
                Wrap(
                  spacing: kPadding, // spacing between items
                  runSpacing: kPadding, // spacing between lines
                  children: [
                    ...List.generate(
                      state.seletedUser.length,
                      (index) {
                        final user = state.seletedUser[index];
                        return IntrinsicWidth(
                          child: MoonMenuItem(
                            onTap: () {},
                            height: 30,
                            menuItemPadding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color:
                                  context.moonColors!.beerus.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(color: context.moonColors!.beerus),
                            ),
                            label: Row(
                              children: [
                                CustomAvatar(
                                  image: user.profile,
                                  high: 25,
                                  width: 25,
                                ),
                                kPadding.gap,
                                Text(user.name),
                              ],
                            ),
                            trailing: MoonButton.icon(
                              onTap: () {
                                bloc.add(RemoverSelectedIndex(index));
                              },
                              icon: Icon(
                                MoonIcons.controls_close_24_light,
                                color: context.moonColors!.trunks,
                                size: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                if (state.textSearch != '')
                  Expanded(
                    child: AppSmartRefreshScrollView(
                      onLoadMore: () async => bloc.add(InitPage()),
                      onRefresh: () async => bloc
                          .add(TextChanged(state.textSearch, widget.band.id)),
                      enableLoadMore: state.isMorePage,
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom,
                        ),
                        itemBuilder: (context, index) {
                          final user = state.user[index];
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: kPadding),
                            child: CustomAddUserCard(
                              select: () {
                                bloc.add(SelectUser(user));
                              },
                              isSelect:
                                  state.seletedUser.any((e) => e.id == user.id),
                              user: user,
                              ontap: () {
                                bloc.add(ClickUser(user.id));
                              },
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => AppDivider.large(),
                        itemCount: state.user.length,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
