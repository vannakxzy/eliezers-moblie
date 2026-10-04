import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/icon_constant.dart';
import '../../../core/utils/widgets/custom_empty_data.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import '../../../core/utils/widgets/custom_question_card.dart';
import '../../profile/bottomsheet/report_buttomsheet.dart';
import '../alert/confirm_delete_cateogry_alert.dart';
import '../domain/entities/category_entity.dart';
import '../edit_category/edit_category_page.dart';
import '../presentation/pages/merge_category_page.dart';
import '../../../shared/widgets/app_refresh_indicator.dart';

import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_back.dart';
import '../../setting/bottomsheet/category_detail_buttonsheet.dart';
import '../../setting/bottomsheet/profile_buttonsheet.dart';
import '../presentation/bloc/category_bloc.dart';
import '../save_question/save_question_page.dart';
import 'bloc/category_detail_bloc.dart';

@RoutePage()
class CategoryDetailPage extends StatefulWidget {
  final int index;
  final CategoryBloc myBloc;
  const CategoryDetailPage({
    super.key,
    required this.index,
    required this.myBloc,
  });
  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState
    extends BasePageBlocState<CategoryDetailPage, CategoryDetailBloc> {
  late CategoryEntity category;
  @override
  void initState() {
    category = widget.myBloc.state.category[widget.index.toInt()];
    bloc.add(TitleChangedEvent("${category.name}"));
    bloc.add(GetQuestioninCategoryEvent(category.id));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
      builder: (context, state) {
        return Scaffold(
            appBar: CustomAppBar(
              leading: CustomBack(
                ontap: () {
                  appRoute.pop(result: "asdfasfdsafds");
                },
              ),
              title: state.title,
              action: IconButton(
                icon: const Icon(MiconMoreHori, size: 35),
                onPressed: () {
                  CategoryDetailButtonsheet.showBottomSheet(
                    context: context,
                    index: widget.index,
                    ontap: (value) async {
                      if (value == actionEnum.delete) {
                        Navigator.pop(context);
                        bool delete = await ConfirmDeleteCateogryAlert.show(
                            context: context);
                        if (delete) {
                          widget.myBloc.add(DeleteCategoryEvent(widget.index));
                        }
                      }
                      if (value == actionEnum.merge) {
                        appRoute.pop();
                        Future.delayed(
                            DurationConstants
                                .defaultGeneralDialogTransitionDuration, () {
                          showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              isScrollControlled: true,
                              builder: ((context) {
                                return MergeSaveScreen(
                                  categoryIndex: widget.index,
                                  categoryBloc: widget.myBloc,
                                );
                              }));
                        });
                      }
                      if (value == actionEnum.edit) {
                        appRoute.pop();
                        Future.delayed(
                            DurationConstants
                                .defaultGeneralDialogTransitionDuration,
                            () async {
                          CategoryEntity category = await showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              isScrollControlled: true,
                              builder: ((context) {
                                return EditCategoryScreen(
                                  categoryIndex: widget.index,
                                  categoryBloc: widget.myBloc,
                                );
                              }));
                          bloc.add(TitleChangedEvent(category.name!));
                          widget.myBloc.add(
                            UpdateCategoryEvent(
                              index: widget.index,
                              name: category.name!,
                              cover: category.cover!,
                            ),
                          );
                        });
                      }
                    },
                    category: widget.myBloc.state.category,
                  );
                },
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: state.isloaing && state.question.isEmpty
                        ? const Center(
                            child: CustomLoading(),
                          )
                        : state.question.isEmpty
                            ? const CustomEmptyData()
                            : AppSmartRefreshScrollView(
                                enableLoadMore: state.isMorePage,
                                onLoadMore: () async => bloc.add(
                                    GetQuestioninCategoryEvent(category.id)),
                                onRefresh: () async =>
                                    bloc.add(Refreshpage(category.id)),
                                child: ListView.builder(
                                  itemCount: state.question.length,
                                  itemBuilder: (context, index) {
                                    final question = state.question[index];
                                    return CustomQuestionCard(
                                      questionEntity: question,
                                      onPressed: () {
                                        bloc.add(ClickQuestion(
                                            question, question.id));
                                      },
                                      onDoubleTap: () {
                                        bloc.add(ClickDoubleTap(index));
                                      },
                                      onTapLike: () {
                                        bloc.add(ClickLike(index));
                                      },
                                      onTapUnHide: () {
                                        bloc.add(ClickUnHide(index));
                                      },
                                      longPressEnd: (value) async {
                                        if (value == actionEnum.share) {
                                          bloc.add(
                                              ClickShareQuestion(question));
                                        }
                                        if (value == actionEnum.report) {
                                          ReportButtomsheet.show(
                                              context: context,
                                              questionId: question.id);
                                        }
                                        if (value == actionEnum.like) {
                                          bloc.add(ClickLike(index));
                                        }
                                        if (value == actionEnum.hide) {
                                          bloc.add(ClickHide(index));
                                        }
                                        if (value == actionEnum.save) {
                                          if (question.is_saved) {
                                            bloc.add(ClickSave(index));
                                          } else {
                                            bool save =
                                                await SaveQuestionToCategoryBottomSheet
                                                    .show(
                                                        context: context,
                                                        questionId: question
                                                            .id) as bool;
                                            if (save) {
                                              bloc.add(ClickSave(index));
                                            }
                                          }
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
