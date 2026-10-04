import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/utils/widgets/custom_app_bar_widget.dart';
import '../../../core/utils/widgets/custom_buttom.dart';
import '../../report/presentation/widgets/report_detail_widget.dart';

import '../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../report/presentation/bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

class ReportButtomsheet extends StatefulWidget {
  final int questionId;
  final int answerId;
  final int commentId;
  final int userId;
  const ReportButtomsheet({
    super.key,
    this.questionId = 0,
    this.answerId = 0,
    this.commentId = 0,
    this.userId = 0,
  });
  static Future<void> show(
          {required BuildContext context,
          int questionId = 0,
          int answerId = 0,
          int userId = 0,
          int commentId = 0}) async =>
      await showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (_) => ReportButtomsheet(
          answerId: answerId,
          commentId: commentId,
          questionId: questionId,
          userId: userId,
        ),
      );
  @override
  State<ReportButtomsheet> createState() => _ReportButtomsheetState();
}

class _ReportButtomsheetState
    extends BasePageBlocState<ReportButtomsheet, ReportBloc> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    bloc.add(InitPage(
        commentId: widget.commentId,
        answerId: widget.answerId,
        questionId: widget.questionId,
        userId: widget.userId));
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.only(bottom: kPadding2),
            child: PageView(
              onPageChanged: (value) {
                bloc.add(PageChangeEvent(value));
              },
              controller: _pageController,
              physics:
                  state.page == 0 ? const NeverScrollableScrollPhysics() : null,
              children: [
                // First page with report types
                Column(
                  children: [
                    CustomAppBarWidget(
                        title: t.common.report,
                        ontap: () {
                          appRoute.pop();
                        }),
                    kPadding.gap,
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding2),
                        child: Column(
                          children: [
                            Text(
                              t.report.description,
                              style: context.moonTypography!.body.text14
                                  .copyWith(color: context.moonColors!.trunks),
                            ),
                            kPadding.gap,
                            Expanded(
                              child: state.getloadinReport
                                  ? const Center(child: CustomLoading())
                                  : SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        spacing: kPadding,
                                        runSpacing: kPadding,
                                        children: [
                                          ...List.generate(
                                            state.reportType.length,
                                            (index) => MoonChip(
                                              onTap: () {
                                                bloc.add(ClickReportTypeEvent(
                                                    index));
                                              },
                                              chipSize: MoonChipSize.sm,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: index ==
                                                            state.selectIndex
                                                        ? context
                                                            .moonColors!.piccolo
                                                        : context
                                                            .moonColors!.trunks,
                                                    width: 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              label: Text(
                                                "${state.reportType[index].name}",
                                                style: context
                                                    .moonTypography!.body.text14
                                                    .copyWith(
                                                        color: index ==
                                                                state
                                                                    .selectIndex
                                                            ? context
                                                                .moonColors!
                                                                .piccolo
                                                            : context
                                                                .moonColors!
                                                                .trunks),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                            if (state.reportType.isNotEmpty)
                              CustomButtom(
                                disable: state.selectIndex >= 0 ? false : true,
                                title: t.common.next,
                                onTap: () {
                                  // Animate to the selected detail page
                                  _pageController.animateToPage(
                                      state.selectIndex + 1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                                isFullWidth: true,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Details pages
                ...List.generate(
                  state.reportTypeDetail.length,
                  (index) {
                    return ReportDetailWidget(
                      index: index,
                      ontapBack: () {
                        // Animate back to the main page
                        _pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
