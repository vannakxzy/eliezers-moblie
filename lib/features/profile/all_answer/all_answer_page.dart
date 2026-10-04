import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/widgets/custom_answer_card.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../../shared/widgets/app_refresh_indicator.dart';
import 'bloc/all_answer_bloc.dart';

@RoutePage()
class AllAnswerPage extends StatefulWidget {
  final int userId;
  const AllAnswerPage({super.key, required this.userId});

  @override
  State<AllAnswerPage> createState() => _AllAnswerPageState();
}

class _AllAnswerPageState
    extends BasePageBlocState<AllAnswerPage, AllAnswerBloc> {
  @override
  void initState() {
    bloc.add(GetAnswerEvent(widget.userId));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t.profileInfo.topAnswer,
      ),
      body: SafeArea(
        child: BlocBuilder<AllAnswerBloc, AllAnswerState>(
          builder: (context, state) {
            if (state.isLoading && state.answer.isEmpty) {
              return const Center(
                child: CustomLoading(),
              );
            }
            return AppSmartRefreshScrollView(
              enableLoadMore: state.isMorePage,
              onLoadMore: () async => bloc.add(GetAnswerEvent(widget.userId)),
              onRefresh: () async => bloc.add(RefreshPage(widget.userId)),
              child: ListView.builder(
                itemCount: state.answer.length,
                itemBuilder: (context, index) {
                  final answer = state.answer[index];
                  return CustomAnswerCrad(
                    isYourQuestion: false,
                    tapAll: false,
                    answertEntity: answer,
                    action: (value) {
                      if (value == answerEnum.ontapCard) {
                        bloc.add(ClickAnswerEvent(answer.question_id));
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
