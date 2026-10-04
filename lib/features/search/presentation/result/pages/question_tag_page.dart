import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../category/save_question/save_question_page.dart';
import '../../../../post/domain/entities/tag_entity.dart';

import '../../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/widgets/custom_empty_data.dart';
import '../../../../../core/utils/widgets/custom_loading.dart';
import '../../../../../core/utils/widgets/custom_question_card.dart';
import '../../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../../profile/bottomsheet/report_buttomsheet.dart';
import '../../../../setting/bottomsheet/profile_buttonsheet.dart';
import '../bloc/bloc/question_tag_bloc.dart';

@RoutePage()
class QuestionTagPage extends StatefulWidget {
  final TagEntity tag;
  const QuestionTagPage({super.key, required this.tag});
  @override
  State<QuestionTagPage> createState() => _QuestionTagPageState();
}

class _QuestionTagPageState
    extends BasePageBlocState<QuestionTagPage, QuestionTagBloc> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    bloc.add(GetQuestion(widget.tag.id));

    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.tag.name,
      ),
      body: BlocBuilder<QuestionTagBloc, QuestionTagState>(
        builder: (context, state) {
          return state.loaingQuestion && state.questions.isEmpty
              ? const Center(child: CustomLoading())
              : state.questions.isEmpty
                  ? const CustomEmptyData()
                  : SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                      child: AppSmartRefreshScrollView(
                        enableLoadMore: state.isMorePage,
                        onLoadMore: () async {
                          bloc.add(GetQuestion(widget.tag.id));
                        },
                        onRefresh: () async {
                          bloc.add(OnRefreshPageEvent(widget.tag.id));
                        },
                        child: ListView.separated(
                          controller: _scrollController,
                          itemCount: state.questions.length,
                          separatorBuilder: (_, index) => const Gap(kPadding),
                          itemBuilder: (_, index) {
                            final questions = state.questions[index];

                            return CustomQuestionCard(
                                questionEntity: questions,
                                onPressed: () {
                                  bloc.add(ClickQuestionEvent(
                                      questions, questions.id));
                                },
                                onDoubleTap: () {
                                  // bloc.add(DoubleTapEvent(index));
                                },
                                onTapLike: () {
                                  bloc.add(ClickLikeEventT(index));
                                },
                                onTapUnHide: () {
                                  bloc.add(ClickUnHideEventT(index));
                                },
                                longPressEnd: (value) async {
                                  if (value == actionEnum.report) {
                                    ReportButtomsheet.show(
                                        context: context,
                                        questionId: questions.id);
                                  }
                                  if (value == actionEnum.like) {
                                    bloc.add(ClickLikeEventT(index));
                                  }
                                  if (value == actionEnum.share) {
                                    bloc.add(ClickShareQuestion(questions));
                                  }
                                  if (value == actionEnum.hide) {
                                    bloc.add(ClickHideEventp(index));
                                  }
                                  if (value == actionEnum.save) {
                                    if (questions.is_saved) {
                                      bloc.add(ClickSaveQuestionT(index));
                                    } else {
                                      bool save =
                                          await SaveQuestionToCategoryBottomSheet
                                                  .show(
                                                      context: context,
                                                      questionId: questions.id)
                                              as bool;
                                      if (save) {
                                        bloc.add(ClickSaveQuestionT(index));
                                      }
                                    }
                                  }
                                });
                          },
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
