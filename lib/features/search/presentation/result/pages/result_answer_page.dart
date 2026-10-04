import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/widgets/custom_answer_card.dart';
import '../../../../../gen/i18n/translations.g.dart';
import '../../../../../shared/widgets/app_divider.dart';
import '../../../../answer/presentation/widget/answer_simmer_widget.dart';
import '../bloc/bloc/result_answer_bloc.dart';
import '../../../../../shared/widgets/app_refresh_indicator.dart';

class ResultAnswerPage extends StatefulWidget {
  String text;
  ResultAnswerPage({super.key, this.text = ''});

  @override
  State<ResultAnswerPage> createState() => _ResultAnswerPageState();
}

class _ResultAnswerPageState
    extends BasePageBlocState<ResultAnswerPage, ResultAnswerBloc> {
  @override
  bool get wantKeepAlive => true; // Enable keep-alive for this screen.
  @override
  void initState() {
    bloc.add(SearchAnswerEvent(widget.text));
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ResultAnswerBloc, ResultAnswerState>(
      builder: (context, state) {
        if (state.isLoaing && state.answer.isEmpty) {
          return SingleChildScrollView(child: AnswerSimmerWidget());
        }

        return AppSmartRefreshScrollView(
          enableLoadMore: state.isMorePage,
          onLoadMore: () async {
            bloc.add(SearchAnswerEvent(widget.text));
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
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: state.recentSearch.length,
                        itemBuilder: (context, index) {
                          final answer = state.recentSearch[index];
                          return Dismissible(
                            background: Container(
                                color: context.moonColors!.jiren,
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  t.common.delete,
                                  style: context.moonTypography!.body.text14
                                      .copyWith(color: Colors.white),
                                )),
                            key: Key("$answer"),
                            direction: DismissDirection
                                .endToStart, // 👈 Only allow swipe left
                            onDismissed: (direction) {
                              bloc.add(RemoveIndex(index));
                            },
                            child: CustomAnswerCrad(
                              opacityLike: 0.3,
                              highlightText: widget.text,
                              tapAll: false,
                              answertEntity: answer,
                              action: (value) {
                                if (value == answerEnum.ontapCard) {
                                  bloc.add(ClickAnswer(answer));
                                }
                                if (value == answerEnum.profile) {
                                  bloc.add(ClickAvatar(answer.user_id));
                                }
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            AppDivider.large(),
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (context, index) => AppDivider.large(),
                  itemCount: state.answer.length,
                  itemBuilder: (context, index) {
                    {
                      final answer = state.answer[index];
                      return CustomAnswerCrad(
                        opacityLike: 0.3,
                        highlightText: widget.text,
                        tapAll: false,
                        answertEntity: answer,
                        action: (value) {
                          if (value == answerEnum.ontapCard) {
                            bloc.add(ClickAnswer(answer));
                          }
                          if (value == answerEnum.profile) {
                            bloc.add(ClickAvatar(answer.user_id));
                          }
                        },
                      );
                    }
                  },
                ),
        );
      },
    );
  }
}
