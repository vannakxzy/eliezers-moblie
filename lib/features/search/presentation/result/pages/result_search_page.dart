import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/base/page/base_page_bloc_state.dart';
import '../bloc/result_search_bloc.dart';
import 'result_answer_page.dart';
import 'result_band_page.dart';
import 'result_discussions_page.dart';
import 'result_question_page.dart';
import 'result_tag_page.dart';
import 'result_user_page.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../gen/i18n/translations.g.dart';

@RoutePage()
class ResultSearchPage extends StatefulWidget {
  int tabIndex;
  String text;
  ResultSearchPage({super.key, required this.text, this.tabIndex = 0});

  @override
  State<ResultSearchPage> createState() => _ResultSearchPageState();
}

class _ResultSearchPageState
    extends BasePageBlocState<ResultSearchPage, ResultSearchBloc>
    with SingleTickerProviderStateMixin {
  late TabController tanController;
  @override
  void initState() {
    tanController = TabController(length: 6, vsync: this);
    tanController.animateTo(widget.tabIndex); // or _tabController.index = 2;
    bloc.add(InitialEvent(widget.text));

    focusNode = FocusNode();
    focusNode.addListener(() {
      // setState(() {
      //   _isFocused = focusNode.hasFocus;
      // });
    });
    super.initState();
  }

  FocusNode focusNode = FocusNode();
  // bool _isFocused = false;
  Timer? _debounce;
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<ResultSearchBloc, ResultSearchState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                leadingWidth: 40,
                toolbarHeight: 40,
                titleSpacing: 0,
                automaticallyImplyLeading: false,
                title: BlocBuilder<ResultSearchBloc, ResultSearchState>(
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: kPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: MoonTextInput(
                                autofocus: true,
                                backgroundColor:
                                    context.moonColors!.beerus.withOpacity(0.2),
                                padding: const EdgeInsets.only(left: kPadding2),
                                height: 35,
                                borderRadius: BorderRadius.circular(333),
                                focusNode: focusNode,
                                controller: state.textSearchController,
                                textInputSize: MoonTextInputSize.lg,
                                activeBorderColor: context.moonColors!.beerus,
                                hintText: t.search.title,
                                style: context.moonTypography!.body.text12,
                                onChanged: (value) {
                                  _debounce?.cancel();
                                  _debounce =
                                      Timer(Duration(milliseconds: 400), () {
                                    bloc.add(TextSearchInputChanged(value));
                                  });
                                },
                                trailing: state.textSearch.isNotEmpty
                                    ? MoonButton.icon(
                                        padding: EdgeInsets.zero,
                                        hoverEffectColor: Colors.transparent,
                                        onTap: () {
                                          bloc.add(ClearTextSearch());
                                          focusNode.requestFocus();
                                        },
                                        icon: Icon(
                                          Icons.clear_rounded,
                                          color: context.moonColors!.trunks,
                                        ),
                                      )
                                    : SizedBox.square()),
                          ),
                          MoonButton(
                            label: Text(
                              t.common.cancel,
                              style: context.moonTypography!.body.text14
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            onTap: () {
                              appRoute.pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: TabBar(
                            controller: tanController,
                            splashFactory:
                                NoSplash.splashFactory, // Disable splash
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            labelColor: context.moonColors!.bulma,
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 3, color: context.moonColors!.piccolo),
                            ),
                            tabs: [
                              Tab(text: t.common.question),
                              Tab(text: t.common.discussion),
                              Tab(text: t.band.title),
                              Tab(text: t.common.user),
                              Tab(text: t.common.answer),
                              Tab(text: t.common.tag),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            behavior: HitTestBehavior.opaque,
                            child: TabBarView(
                              controller: tanController,
                              children: [
                                ResultQuestionPage(
                                    text: state.textSearch,
                                    key: ValueKey(
                                        'question-${state.textSearch}')),
                                ResultDiscussionsPage(
                                    text: state.textSearch,
                                    key: ValueKey(
                                        'discussion-${state.textSearch}')),
                                ResultbandPage(
                                    text: state.textSearch,
                                    key: ValueKey('band-${state.textSearch}')),
                                ResultUserPage(
                                    text: state.textSearch,
                                    key: ValueKey('user-${state.textSearch}')),
                                ResultAnswerPage(
                                    text: state.textSearch,
                                    key:
                                        ValueKey('answer-${state.textSearch}')),
                                ResultTagPage(
                                    text: state.textSearch,
                                    key: ValueKey('tag-${state.textSearch}')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // if (_isFocused)
                    //   BlocBuilder<ResultSearchBloc, ResultSearchState>(
                    //     builder: (context, state) {
                    //       return Column(
                    //         children: [
                    //           Expanded(
                    //             child: ListView.separated(
                    //               padding: const EdgeInsets.symmetric(
                    //                   horizontal: kPadding2),
                    //               itemCount: state.recentSearch.length,
                    //               separatorBuilder: (_, index) => const Gap(4),
                    //               itemBuilder: (_, index) {
                    //                 final recentSearch = state.recentSearch[index];
                    //                 return MoonMenuItem(
                    //                   backgroundColor: context.moonColors?.goku,
                    //                   horizontalGap: kPadding,
                    //                   onTap: () {
                    //                     bloc.add(ClickSearchEvent(recentSearch));
                    //                   },
                    //                   menuItemPadding: const EdgeInsets.symmetric(
                    //                       horizontal: kPadding),
                    //                   leading:
                    //                       const Icon(MoonIcons.time_time_32_light),
                    //                   label: Text(recentSearch),
                    //                   trailing: MoonButton.icon(
                    //                     onTap: () {
                    //                       bloc.add(ClickRemoveHistoryItem(index));
                    //                     },
                    //                     icon: const Icon(
                    //                         MoonIcons.controls_close_32_light),
                    //                   ),
                    //                 );
                    //               },
                    //             ),
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
