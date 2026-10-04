import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../bloc/bloc.dart';
import '../bloc/bloc/data_tag_answer_bloc.dart';
import '../bloc/data_tag_bloc.dart';
import '../../../profile/domain/entities/top_tag_entity.dart';

import '../../../../core/utils/widgets/custom_answer_card.dart';
import '../../../../core/utils/widgets/custom_empty_data.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';

class DataTagAnswer extends StatefulWidget {
  final int index;
  final int tagId;
  final int userId;
  final List<TopTagEntity> topTagEntity;
  const DataTagAnswer(
      {super.key,
      required this.index,
      required this.tagId,
      required this.topTagEntity,
      required this.userId});

  @override
  State<DataTagAnswer> createState() => _DataTagAnswerState();
}

class _DataTagAnswerState
    extends BasePageBlocState<DataTagAnswer, DataTagAnswerBloc> {
  late DataTagBloc mybloc;

  @override
  void initState() {
    super.initState();
    bloc.add(InitPage(tagLenght: widget.topTagEntity.length));
    bloc.add(GetAnswer(
        index: widget.index, userId: widget.userId, tagId: widget.tagId));
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<DataTagAnswerBloc, DataTagAnswerState>(
      builder: (context, state) {
        if (state.isloading.isEmpty) {
          return const Text("null");
        }
        if (state.isloading[widget.index] == true &&
            state.answer[widget.index].isEmpty) {
          return const Center(child: CustomLoading());
        }
        if (state.answer[widget.index].isEmpty) {
          return const Center(child: CustomEmptyData());
        }
        return AppSmartRefreshScrollView(
          enableLoadMore: state.isMorePage[widget.index],
          onRefresh: () async {
            bloc.add(RefreshPage(
                index: widget.index,
                userId: widget.userId,
                tagId: widget.tagId));
          },
          onLoadMore: () async {
            bloc.add(GetAnswer(
                index: widget.index,
                userId: widget.userId,
                tagId: widget.tagId));
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: state.answer[widget.index].length,
            itemBuilder: (context, index) {
              final answer = state.answer[widget.index][index];
              return CustomAnswerCrad(
                opacityLike: 0.5,
                tapAll: false,
                action: (value) {
                  debugPrint("fsadfsadfsad");
                  if (value == answerEnum.ontapCard) {
                    bloc.add(ClickAnswer(answer));
                  }
                },
                answertEntity: answer,
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
