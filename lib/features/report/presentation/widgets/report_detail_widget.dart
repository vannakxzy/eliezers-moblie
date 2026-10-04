import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../bloc/report_bloc.dart';

import '../../../../core/utils/widgets/custom_app_bar_widget.dart';
import '../../../../gen/i18n/translations.g.dart';

class ReportDetailWidget extends StatefulWidget {
  final int index;
  final Function ontapBack;
  const ReportDetailWidget(
      {super.key, required this.index, required this.ontapBack});

  @override
  State<ReportDetailWidget> createState() => _ReportDetailWidgetState();
}

class _ReportDetailWidgetState extends State<ReportDetailWidget> {
  late ReportBloc mybloc;
  @override
  void initState() {
    mybloc = BlocProvider.of<ReportBloc>(context);
    mybloc.add(GetReportTypeDetailEvent(widget.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomAppBarWidget(
                isClose: false,
                title: "${state.reportType[widget.index].name}",
                ontap: () {
                  widget.ontapBack();
                }),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: kPadding2),
                child: Column(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        ...List.generate(
                          state.reportTypeDetail[widget.index].length,
                          (index) {
                            final detail =
                                state.reportTypeDetail[widget.index][index];
                            return GestureDetector(
                              onTap: () {
                                mybloc.add(
                                    ClickReportTypeDetailEvent(detail.name!));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(bottom: kPadding2),
                                color: Colors.transparent,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${detail.name}",
                                        style:
                                            context.moonTypography!.body.text14,
                                      ),
                                    ),
                                    kPadding2.gap,
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: context.moonColors!.trunks),
                                      ),
                                      child: state.selectedReportDetail
                                              .contains(detail.name)
                                          ? Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: context
                                                        .moonColors!.trunks),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Text(t.report.submitHitText),
                        kPadding.gap,
                        MoonTextArea(
                          hintText: t.common.message,
                          minLines: 4,
                          height: 100,
                          onChanged: (value) {
                            mybloc.add(MessageChangedEvent(value));
                          },
                        )
                      ],
                    )),
                    CustomButtom(
                      buttonSize: MoonButtonSize.md,
                      disable: state.selectedReportDetail.isNotEmpty ||
                              state.message.isNotEmpty
                          ? false
                          : true,
                      title: t.common.ok,
                      onTap: () {
                        mybloc.add(ClickCreateReportEvent(
                          widget.index,
                        ));
                      },
                      isFullWidth: true,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
