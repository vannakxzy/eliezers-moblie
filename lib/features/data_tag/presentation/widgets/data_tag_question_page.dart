import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_question_card.dart';
import '../bloc/bloc/data_tag_question_bloc.dart';
import '../../../../core/utils/widgets/custom_empty_data.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../category/save_question/save_question_page.dart';
import '../../../profile/domain/entities/top_tag_entity.dart';
import '../../../setting/bottomsheet/profile_buttonsheet.dart';

class DataTagQuestion extends StatefulWidget {
  final int index;
  final int tagId;
  final int userId;
  final List<TopTagEntity> tag;
  const DataTagQuestion(
      {super.key,
      required this.index,
      required this.tagId,
      required this.tag,
      required this.userId});

  @override
  State<DataTagQuestion> createState() => _DataTagQuestionState();
}

class _DataTagQuestionState
    extends BasePageBlocState<DataTagQuestion, DataTagQuestionBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(InitPage(tag: widget.tag, index: 0));
    bloc.add(GetQuestionEventq(
        index: widget.index, userId: widget.userId, tagId: widget.tagId));
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<DataTagQuestionBloc, DataTagQuestionState>(
      builder: (context, state) {
        if (state.isloading.isEmpty) {
          return const Text("null");
        }
        if (state.isloading[widget.index] == true &&
            state.question[widget.index].isEmpty) {
          return const Center(child: CustomLoading());
        }
        if (state.question[widget.index].isEmpty) {
          return const Center(child: CustomEmptyData());
        }

        return AppSmartRefreshScrollView(
          enableLoadMore: state.isMorePage[widget.index],
          onLoadMore: () async {
            bloc.add(GetQuestionEventq(
                index: widget.index,
                userId: widget.userId,
                tagId: widget.tagId));
          },
          onRefresh: () async {
            bloc.add(RefreshPaged(
                index: widget.index,
                userId: widget.userId,
                tagId: widget.tagId));
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            key: ValueKey(widget.index),
            padding: const EdgeInsets.only(top: kPadding),
            itemCount: state.question[widget.index].length,
            itemBuilder: (context, index) {
              final question = state.question[widget.index][index];
              return CustomQuestionCard(
                questionEntity: question,
                onPressed: () {
                  bloc.add(ClickQuestionEvetn(question, question.id));
                },
                longPressEnd: (value) async {
                  if (value == actionEnum.share) {
                    bloc.add(ClickShare(question));
                  }
                  if (value == actionEnum.like) {
                    bloc.add(ClickLikeEvent(widget.index, index));
                  }
                  if (value == actionEnum.hide) {
                    bloc.add(ClickHideEvent(widget.index, index));
                  }
                  if (value == actionEnum.save) {
                    if (question.is_saved) {
                      bloc.add(ClickSaveQuesition(widget.index, index));
                    } else {
                      bool save = await SaveQuestionToCategoryBottomSheet.show(
                          context: context, questionId: question.id) as bool;
                      if (save) {
                        bloc.add(ClickSaveQuesition(widget.index, index));
                      }
                    }
                  }
                },
                onTapLike: () {
                  bloc.add(ClickLikeEvent(widget.index, index));
                },
                onDoubleTap: () {},
              );
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
