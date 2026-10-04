// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/helper/fuction.dart';
// import 'package:moon_design/moon_design.dart';
// import '../../../../core/utils/widgets/custom_app_bar_widget.dart';
// import '../../../../core/utils/widgets/custom_buttom.dart';
// import '../widgets/report_detail_widget.dart';

// import '../../../../core/constants/constants.dart';
// import '../../../../core/utils/widgets/custom_loading.dart';
// import '../../../../gen/i18n/translations.g.dart';
// import '../bloc/bloc.dart';
// import '../../../../app/base/page/base_page_bloc_state.dart';

// class ReportButtomSheet extends StatelessWidget {
//   const ReportButtomSheet({
//     super.key,
//   });

//   static Future<void> show(BuildContext context) => showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         useSafeArea: true,
//         builder: (_) => const ReportButtomSheet(),
//         backgroundColor: Colors.transparent,
//       );

//   @override
//   Widget build(BuildContext context) {
//     return const ReportPage();
//   }
// }

// class ReportPage extends StatefulWidget {
//   final int questionId;
//   final int answerId;
//   final int commentId;
//   const ReportPage({
//     super.key,
//     this.questionId = 0,
//     this.answerId = 0,
//     this.commentId = 0,
//   });

//   @override
//   State<ReportPage> createState() => _ReportPageState();
// }

// class _ReportPageState extends BasePageBlocState<ReportPage, ReportBloc> {
//   final PageController _pageController = PageController(initialPage: 0);

//   @override
//   void initState() {
//     bloc.add(GetReportTypeEvent());
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget buildPage(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: BlocBuilder<ReportBloc, ReportState>(
//           builder: (context, state) {
//             return PageView(
//               onPageChanged: (value) {
//                 bloc.add(PageChangeEvent(value));
//               },
//               controller: _pageController,
//               physics:
//                   state.page == 0 ? const NeverScrollableScrollPhysics() : null,
//               children: [
//                 Column(
//                   children: [
//                     CustomAppBarWidget(
//                         title: t.common.report,
//                         ontap: () {
//                           appRoute.pop();
//                         }),
//                     kPadding.gap,
//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.all(kPadding2),
//                         child: Column(
//                           children: [
//                             Text(t.report.description),
//                             kPadding.gap,
//                             Expanded(
//                               child: state.getloadinReport
//                                   ? const Center(child: CustomLoading())
//                                   : SizedBox(
//                                       width: double.infinity,
//                                       child: Wrap(
//                                         spacing: kPadding,
//                                         runSpacing: kPadding,
//                                         children: [
//                                           ...List.generate(
//                                             state.reportType.length,
//                                             (index) => MoonChip(
//                                               onTap: () {
//                                                 bloc.add(ClickReportTypeEvent(
//                                                     index));
//                                               },
//                                               chipSize: MoonChipSize.md,
//                                               decoration: BoxDecoration(
//                                                 color:
//                                                     index == state.selectIndex
//                                                         ? context
//                                                             .moonColors!.piccolo
//                                                         : Colors.transparent,
//                                                 border: Border.all(
//                                                     color: index ==
//                                                             state.selectIndex
//                                                         ? context
//                                                             .moonColors!.piccolo
//                                                         : context.moonColors!
//                                                             .beerus),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         kRadius2),
//                                               ),
//                                               label: Text(
//                                                 "${state.reportType[index].name}",
//                                                 style: context
//                                                     .moonTypography!.body.text14
//                                                     .copyWith(
//                                                         color: index ==
//                                                                 state
//                                                                     .selectIndex
//                                                             ? Colors.white
//                                                             : context
//                                                                 .moonColors!
//                                                                 .trunks),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                             ),
//                             if (state.reportType.isNotEmpty)
//                               CustomButtom(
//                                 buttonSize: MoonButtonSize.md,
//                                 disable: state.selectIndex >= 0 ? false : true,
//                                 title: t.common.next,
//                                 onTap: () {
//                                   _pageController.nextPage(
//                                       duration:
//                                           const Duration(milliseconds: 300),
//                                       curve: Curves.ease);
//                                 },
//                                 isFullWidth: true,
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Stack(
//                   children: [
//                     ...List.generate(
//                       state.reportTypeDetail.length,
//                       (index) {
//                         return index == state.selectIndex
//                             ? ReportDetailWidget(
//                                 index: index,
//                                 ontapBack: () {
//                                   unFocus();
//                                   _pageController.previousPage(
//                                       duration:
//                                           const Duration(milliseconds: 300),
//                                       curve: Curves.ease);
//                                 },
//                               )
//                             : const SizedBox.shrink();
//                       },
//                     ),
//                   ],
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
