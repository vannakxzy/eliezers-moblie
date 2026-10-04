import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../../gen/i18n/translations.g.dart';
import '../../../../category/save_question/save_question_page.dart';
import '../../../../profile/bottomsheet/report_buttomsheet.dart';
import '../bloc/bloc/result_question_bloc.dart';

import '../../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/widgets/custom_question_card.dart';
import '../../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../../setting/bottomsheet/profile_buttonsheet.dart';

class ResultDiscussionsPage extends StatefulWidget {
  final String text;
  const ResultDiscussionsPage({super.key, required this.text});
  @override
  State<ResultDiscussionsPage> createState() => _ResultDiscussionsPageState();
}

class _ResultDiscussionsPageState
    extends BasePageBlocState<ResultDiscussionsPage, ResultQuestionBloc> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    bloc.add(SearchQuestionEvent(widget.text));
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ResultQuestionBloc, ResultQuestionState>(
      builder: (context, state) {
        return
            // state.loaingQuestion && state.questions.isEmpty
            //     ? const Center(child: CustomLoading())
            //     : state.questions.isEmpty
            //         ? const CustomEmptyData()
            //         :
            AppSmartRefreshScrollView(
          enableLoadMore: state.isMorePage,
          onLoadMore: () async {
            bloc.add(SearchQuestionEvent(widget.text));
          },
          onRefresh: () async {
            bloc.add(OnRefreshPageEvent(widget.text));
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
                            final questions = state.recentSearch[index];
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
                              key: Key("$questions"),
                              direction: DismissDirection
                                  .endToStart, // 👈 Only allow swipe left
                              onDismissed: (direction) {
                                bloc.add(RemoveIndex(index));
                              },
                              child: CustomQuestionCard(
                                  questionEntity: questions,
                                  onPressed: () {
                                    bloc.add(ClickQuestionEvetn(
                                        questions, questions.id));
                                  },
                                  onDoubleTap: () {
                                    bloc.add(DoubleTapEvent(index));
                                  },
                                  onTapLike: () {
                                    bloc.add(ClickLikeEvent(index));
                                  },
                                  textHighlight: widget.text,
                                  onTapUnHide: () {
                                    bloc.add(ClickUnHideEvent(index));
                                  },
                                  longPressEnd: (value) async {
                                    if (value == actionEnum.report) {
                                      ReportButtomsheet.show(
                                          context: context,
                                          questionId: questions.id);
                                    }
                                    if (value == actionEnum.share) {
                                      bloc.add(ClickShareQuestion(questions));
                                    }
                                    if (value == actionEnum.like) {
                                      bloc.add(ClickLikeEvent(index));
                                    }
                                    if (value == actionEnum.hide) {
                                      bloc.add(ClickHideEvent(index));
                                    }
                                    if (value == actionEnum.save) {
                                      if (questions.is_saved) {
                                        bloc.add(ClickSaveQuestion(index));
                                      } else {
                                        bool save =
                                            await SaveQuestionToCategoryBottomSheet
                                                .show(
                                                    context: context,
                                                    questionId:
                                                        questions.id) as bool;
                                        if (save) {
                                          bloc.add(ClickSaveQuestion(index));
                                        }
                                      }
                                    }
                                  }),
                            );
                          },
                          separatorBuilder: (context, index) => const Gap(0),
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  controller: _scrollController,
                  itemCount: state.questions.length,
                  separatorBuilder: (_, index) => const Gap(kPadding),
                  itemBuilder: (_, index) {
                    final questions = state.questions[index];
                    return CustomQuestionCard(
                        questionEntity: questions,
                        onPressed: () {
                          bloc.add(ClickQuestionEvetn(questions, questions.id));
                        },
                        onDoubleTap: () {
                          bloc.add(DoubleTapEvent(index));
                        },
                        onTapLike: () {
                          bloc.add(ClickLikeEvent(index));
                        },
                        textHighlight: widget.text,
                        onTapUnHide: () {
                          bloc.add(ClickUnHideEvent(index));
                        },
                        longPressEnd: (value) async {
                          if (value == actionEnum.report) {
                            ReportButtomsheet.show(
                                context: context, questionId: questions.id);
                          }
                          if (value == actionEnum.share) {
                            bloc.add(ClickShareQuestion(questions));
                          }
                          if (value == actionEnum.like) {
                            bloc.add(ClickLikeEvent(index));
                          }
                          if (value == actionEnum.hide) {
                            bloc.add(ClickHideEvent(index));
                          }
                          if (value == actionEnum.save) {
                            if (questions.is_saved) {
                              bloc.add(ClickSaveQuestion(index));
                            } else {
                              bool save =
                                  await SaveQuestionToCategoryBottomSheet.show(
                                      context: context,
                                      questionId: questions.id) as bool;
                              if (save) {
                                bloc.add(ClickSaveQuestion(index));
                              }
                            }
                          }
                        });
                  },
                ),
        );
      },
    );
  }
}
