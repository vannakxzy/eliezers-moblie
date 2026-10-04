import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../profile/bottomsheet/report_buttomsheet.dart';
import '../bloc/bloc/all_book_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_book.dart';
import '../../../../core/utils/widgets/custom_empty_data.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../core/utils/widgets/custom_question_card.dart';
import '../../../../di/di.dart';
import '../../domain/entities/question_entity.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';

import '../../../../app/base/navigation/app_navigator.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../../../category/save_question/save_question_page.dart';
import '../../../setting/bottomsheet/profile_buttonsheet.dart';

class AllBookPage extends StatefulWidget {
  final int index;
  const AllBookPage({super.key, required this.index});

  @override
  State<AllBookPage> createState() => _AllBookPageState();
}

class _AllBookPageState extends BasePageBlocState<AllBookPage, AllBookBloc> {
  late CategoryBloc mybloc;

  @override
  void initState() {
    mybloc = BlocProvider.of<CategoryBloc>(context);
    bloc.add(InitPage(mybloc.state.category));
    String q = mybloc.state.category[widget.index].name ?? "";
    Future.delayed(const Duration(milliseconds: 100), () {
      bloc.add(GetQuestionEventd(widget.index, q));
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   bloc.state.scrollController[widget.index].addListener(() {
      //     debugPrint(
      //         "------${bloc.state.scrollController[widget.index].position.pixels}");
      //     if (bloc.state.scrollController[widget.index].position.pixels ==
      //         bloc.state.scrollController[widget.index].position
      //             .maxScrollExtent) {
      //       if (bloc.state.isMorePage[widget.index]) {
      //         bloc.add(GetQuestionEventd(widget.index, q));
      //       }
      //     }
      //   });
      // });
    });
    super.initState();
  }

  @override
  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<AllBookBloc, AllBookState>(
      builder: (context, state) {
        if (state.isloading.isEmpty || state.scrollController.isEmpty) {
          return const Center(
              child: Text("No data available or invalid index"));
        }

        return Column(
          children: [
            Expanded(
                child: state.isloading[widget.index] &&
                        state.questions[widget.index].isEmpty
                    ? const Center(child: CustomLoading())
                    : AppSmartRefreshScrollView(
                        enableLoadMore: state.isMorePage[widget.index],
                        onLoadMore: () async {
                          bloc.add(GetQuestionEventd(widget.index,
                              mybloc.state.category[widget.index].name ?? ""));
                        },
                        onRefresh: () async {
                          bloc.add(RefreshPaged(widget.index,
                              mybloc.state.category[widget.index].name ?? ""));
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  getIt.get<IAppNavigator>().push(
                                      AppRouteInfo.categoryDetail(
                                          index: widget.index, mybloc: mybloc));
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.only(
                                      left: kPadding,
                                      right: kPadding,
                                      top: kPadding),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomBook(
                                        height: 50,
                                        width: 40,
                                        image:
                                            "${mybloc.state.category[widget.index].cover}",
                                      ),
                                      kPadding.gap,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${mybloc.state.category[widget.index].name}",
                                            style: context
                                                .moonTypography!.body.text16
                                                .copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${mybloc.state.category[widget.index].count} ${t.common.question}",
                                            style: context
                                                .moonTypography!.body.text12
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: context
                                                        .moonColors!.trunks),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ...List.generate(
                                state.questions[widget.index].length,
                                (index) {
                                  QuestionEntity question =
                                      state.questions[widget.index][index];
                                  return CustomQuestionCard(
                                    longPressEnd: (value) async {
                                      if (value == actionEnum.report) {
                                        ReportButtomsheet.show(
                                            context: context,
                                            questionId: question.id);
                                      }
                                      if (value == actionEnum.like) {
                                        bloc.add(ClickLikeQuestionByCategory(
                                            index, widget.index));
                                      }
                                      if (value == actionEnum.hide) {
                                        bloc.add(ClickHideQuestionByCategory(
                                            index, widget.index));
                                      }
                                      if (value == actionEnum.share) {
                                        bloc.add(ClickShareQuestion(question));
                                      }
                                      if (value == actionEnum.save) {
                                        if (question.is_saved) {
                                          bloc.add(ClickSaveQuestiond(
                                              index, widget.index));
                                        } else {
                                          bool save =
                                              await SaveQuestionToCategoryBottomSheet
                                                  .show(
                                                      context: context,
                                                      questionId:
                                                          question.id) as bool;
                                          if (save) {
                                            bloc.add(ClickSaveQuestiond(
                                                index, widget.index));
                                          }
                                        }
                                      }
                                    },
                                    onDoubleTap: () {
                                      bloc.add(ClickDoubleTanQuestionByCategory(
                                          index, widget.index));
                                    },
                                    onTapLike: () {
                                      bloc.add(ClickLikeQuestionByCategory(
                                          index, widget.index));
                                    },
                                    onTapUnHide: () {
                                      bloc.add(ClickUnhideQuestion(
                                          index, widget.index));
                                    },
                                    questionEntity: question,
                                    onPressed: () {
                                      bloc.add(ClickQuestionEventd(
                                          question.id, question));
                                    },
                                  );
                                },
                              ),
                              if (state.questions[widget.index].isEmpty)
                                SizedBox(
                                    height: MediaQuery.sizeOf(context).height,
                                    child:
                                        const Center(child: CustomEmptyData()))
                            ],
                          ),
                        ),
                      )),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
