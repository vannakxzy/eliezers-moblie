import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import '../../../core/utils/widgets/custom_question_card.dart';
import '../../../shared/widgets/app_refresh_indicator.dart';

import '../../../gen/i18n/translations.g.dart';
import '../../category/save_question/save_question_page.dart';
import '../../setting/bottomsheet/profile_buttonsheet.dart';
import '../bottomsheet/report_buttomsheet.dart';
import 'bloc/all_question_bloc.dart';

@RoutePage()
class ALlQuestionPage extends StatefulWidget {
  final int userId;
  const ALlQuestionPage({super.key, required this.userId});

  @override
  State<ALlQuestionPage> createState() => _ALlQuestionPageState();
}

class _ALlQuestionPageState
    extends BasePageBlocState<ALlQuestionPage, AllQuestionBloc> {
  @override
  void initState() {
    bloc.add(GetQuestionEvent(widget.userId));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: t.profileInfo.topQuestion,
        ),
        body: SafeArea(
          child: BlocBuilder<AllQuestionBloc, AllQuestionState>(
            builder: (context, state) {
              if (state.isLoading && state.questions.isEmpty) {
                return const Center(
                  child: CustomLoading(),
                );
              }
              return AppSmartRefreshScrollView(
                enableLoadMore: state.isMorePage,
                onLoadMore: () async =>
                    bloc.add(GetQuestionEvent(widget.userId)),
                onRefresh: () async => bloc.add(RefreshPage(widget.userId)),
                child: ListView.builder(
                  itemCount: state.questions.length,
                  itemBuilder: (context, index) {
                    final question = state.questions[index];
                    return CustomQuestionCard(
                      longPressEnd: (value) {
                        if (value == actionEnum.report) {
                          ReportButtomsheet.show(context: context);
                        }
                        if (value == actionEnum.like) {
                          bloc.add(ClickLikeEvent(index));
                        }
                        if (value == actionEnum.share) {
                          bloc.add(ClickShareQuestion(question));
                        }
                        if (value == actionEnum.hide) {
                          bloc.add(ClickHideEvent(
                            index,
                          ));
                        }
                        if (value == actionEnum.save) {
                          Future.delayed(const Duration(milliseconds: 200),
                              () async {
                            await SaveQuestionToCategoryBottomSheet.show(
                                context: context,
                                questionId: question.id) as bool;
                          });
                        }
                      },
                      onDoubleTap: () {
                        bloc.add(ClickDoubleTapEvent(index));
                      },
                      onTapLike: () {
                        bloc.add(ClickLikeEvent(index));
                      },
                      onTapUnHide: () {
                        bloc.add(ClickUnHideEvent(index));
                      },
                      questionEntity: question,
                      onPressed: () async {
                        bloc.add(ClickQuestionEvent(question.id, question));
                      },
                    );
                  },
                ),
              );
            },
          ),
        ));
  }
}
