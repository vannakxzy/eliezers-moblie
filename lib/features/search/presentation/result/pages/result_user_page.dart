import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/widgets/custom_avata.dart';
import '../../../../../core/utils/widgets/custom_loading.dart';
import '../../../../../gen/i18n/translations.g.dart';
import '../bloc/bloc/result_user_bloc.dart';
import '../../../../../shared/widgets/app_refresh_indicator.dart';

class ResultUserPage extends StatefulWidget {
  final String text;
  const ResultUserPage({super.key, required this.text});

  @override
  State<ResultUserPage> createState() => _ResultUserPageState();
}

class _ResultUserPageState
    extends BasePageBlocState<ResultUserPage, ResultUserBloc> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    bloc.add(SearchUserEvent(widget.text));
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget buildPage(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      // padding: const EdgeInsets.symmetric(vertical: kPadding),
      child: BlocBuilder<ResultUserBloc, ResultUserState>(
        builder: (context, state) {
          if (state.isloading && state.profile.isEmpty) {
            return const SingleChildScrollView(
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: CustomLoading(),
              )),
            );
          }
          // if (state.profile.isEmpty) {
          //   return const Center(
          //     child: CustomEmptyData(),
          //   );
          // }
          return AppSmartRefreshScrollView(
            enableLoadMore: state.isMorePage,
            onLoadMore: () async {
              bloc.add(SearchUserEvent(widget.text));
            },
            onRefresh: () async {
              bloc.add(RefreshPage(widget.text));
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
                        child: Container(
                          padding: EdgeInsets.all(kPadding),
                          child: ListView.separated(
                            controller: _scrollController,
                            itemCount: state.recentSearch.length,
                            itemBuilder: (context, index) {
                              final user = state.recentSearch[index];
                              return Dismissible(
                                background: Container(
                                    color: context.moonColors!.jiren,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      t.common.delete,
                                      style: context.moonTypography!.body.text14
                                          .copyWith(color: Colors.white),
                                    )),
                                key: Key("$user"),
                                direction: DismissDirection
                                    .endToStart, // 👈 Only allow swipe left
                                onDismissed: (direction) {
                                  bloc.add(RemoveIndex(index));
                                },
                                child: MoonMenuItem(
                                  backgroundColor: Colors.transparent,
                                  onTap: () {
                                    bloc.add(ClickUser(user));
                                  },
                                  menuItemPadding: EdgeInsets.zero,
                                  leading: CustomAvatar(
                                    high: 50,
                                    width: 50,
                                    ontapProfile: () {
                                      bloc.add(ClickUser(user));
                                    },
                                    image: user.profile,
                                  ),
                                  label: Padding(
                                    padding:
                                        const EdgeInsets.only(left: kPadding),
                                    child: Text(user.name),
                                  ),
                                  // trailing: CloseButton(
                                  //   onPressed: () {
                                  //     bloc.add(RemoveIndex(index));
                                  //   },
                                  // ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const Gap(0),
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.all(kPadding),
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: state.profile.length,
                      itemBuilder: (context, index) {
                        final user = state.profile[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                bloc.add(ClickUser(user));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: kPadding),
                                child: Row(
                                  children: [
                                    CustomAvatar(
                                      high: 50,
                                      width: 50,
                                      ontapProfile: () {
                                        bloc.add(ClickUser(user));
                                      },
                                      image: user.profile,
                                    ),
                                    kPadding.gap,
                                    Text(
                                      user.name,
                                      style: context
                                          .moonTypography!.heading.text18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const Gap(0),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
