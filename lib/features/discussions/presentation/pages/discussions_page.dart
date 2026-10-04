import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_discusstion.dart';
import '../../../../data/models/filter_entity.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../category/save_question/save_question_page.dart';
import '../../../setting/bottomsheet/profile_buttonsheet.dart';
import '../../showbuttomsheet/filter_widget_buttomsheet.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../widgets/discussion_shimmer.dart';

@RoutePage()
class DiscussionsPage extends StatefulWidget {
  const DiscussionsPage({super.key});

  @override
  State<DiscussionsPage> createState() => _DiscussionsPageState();
}

class _DiscussionsPageState
    extends BasePageBlocState<DiscussionsPage, DiscussionsBloc> {
  @override
  void initState() {
    bloc.add(GetDiscussion());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DiscussionsBloc, DiscussionsState>(
          builder: (context, state) {
            return Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: Row(
                        children: [
                          Text(t.common.discussion,
                              style: context.moonTypography!.heading.text20),
                          Spacer(),
                          MoonButton.icon(
                            onTap: () {
                              bloc.add(ClickPostDiscussion());
                            },
                            icon: Icon(MoonIcons.controls_plus_16_regular),
                          ),
                          Stack(
                            children: [
                              MoonButton.icon(
                                onTap: () async {
                                  final filer = await FilterWidget.show(
                                      context, state.filter);
                                  if (filer != null) {
                                    bloc.add(ApplyFilerEvent(filer));
                                  }
                                },
                                icon: Icon(MoonIcons.media_tuner_16_regular),
                              ),
                              if (state.filter.activeFilterCount != 0)
                                Positioned(
                                  right: kPadding / 2,
                                  child: ClipOval(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 15,
                                      width: 15,
                                      color: Colors.red,
                                      child: Text(
                                        "${state.filter.activeFilterCount}",
                                        style: context
                                            .moonTypography!.heading.text10
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppDivider()
                  ],
                ),
                Expanded(
                  child: AppSmartRefreshScrollView(
                    enableLoadMore: state.isMorePage,
                    onLoadMore: () async {
                      if (bloc.state.isMorePage) {
                        bloc.add(GetDiscussion());
                      }
                    },
                    onRefresh: () async {
                      bloc.add(RefreshPage());
                    },
                    child: state.discussion.isEmpty
                        ? DiscussionShimmer()
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              final discussion = state.discussion[index];
                              return Column(
                                children: [
                                  CustomDiscussion(
                                    longPressEnd: (value) async {
                                      if (value == actionEnum.share) {
                                        bloc.add(ClickShare(discussion));
                                      }
                                      if (value == actionEnum.like) {
                                        bloc.add(ClickLikeEvent(index));
                                      }
                                      if (value == actionEnum.hide) {
                                        bloc.add(ClickHideEvent(index));
                                      }
                                      if (value == actionEnum.save) {
                                        if (discussion.is_saved) {
                                          bloc.add(ClickSaveDiscussion(index));
                                        } else {
                                          bool save =
                                              await SaveQuestionToCategoryBottomSheet
                                                  .show(
                                                      context: context,
                                                      questionId: discussion
                                                          .id) as bool;
                                          if (save) {
                                            bloc.add(
                                                ClickSaveDiscussion(index));
                                          }
                                        }
                                      }
                                    },
                                    onDoubleTap: () {
                                      // bloc.add(ClickDoubleTapEvent(index));
                                    },
                                    onTapLike: () {
                                      bloc.add(ClickLikeEvent(index));
                                    },
                                    onTapUnHide: () {
                                      bloc.add(ClickUnHideEvent(index));
                                    },
                                    discussion: discussion,
                                    onPressed: () async {
                                      bloc.add(ClickDiscussion(discussion));
                                    },
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (_, index) => AppDivider.normal(),
                            itemCount: state.discussion.length,
                          ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

List filterDate = ["Newest", "Latest", "Highest score"];
