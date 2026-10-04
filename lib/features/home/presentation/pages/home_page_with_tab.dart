// import 'package:auto_route/annotations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/constants/size_constant.dart';
// import '../../../category/save_question/save_question_page.dart';
// import '../widgets/all_book_page.dart';
// import '../../../setting/bottomsheet/profile_buttonsheet.dart';
// import 'package:moon_design/moon_design.dart';

// import '../../../../app/base/page/base_page_bloc_state.dart';
// import '../../../../core/utils/widgets/custom_question_card.dart';
// import '../../../../gen/i18n/translations.g.dart';
// import '../../../../shared/widgets/app_divider.dart';
// import '../../../../shared/widgets/app_refresh_indicator.dart';
// import '../../../bottom_navigationbar/bloc/scaffold_with_navbar_bloc.dart';
// import '../bloc/bloc.dart';
// import '../widgets/home_shimmer.dart';
// import 'drawer_home.dart';

// @RoutePage()
// class HomePage extends StatefulWidget {
//   const HomePage({super.key}); // Don't make this const
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends BasePageBlocState<HomePage, HomeBloc>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   final _nestedScrollView = ScrollController();

//   @override
//   void initState() {
//     _tabController = TabController(length: 1, vsync: this);
//     _scaffoldWithNavbarBloc = BlocProvider.of<ScaffoldWithNavbarBloc>(context);
//     bloc.add(GetQuestionEvent());
//     bloc.add(GetCategoryEvent());

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scaffoldWithNavbarBloc.scrollController.dispose();
//     super.dispose();
//   }

//   late ScaffoldWithNavbarBloc _scaffoldWithNavbarBloc;
//   @override
//   Widget buildPage(BuildContext context) {
//     return BlocConsumer<HomeBloc, HomeState>(
//       listener: (context, state) {
//         if (state.category.isNotEmpty) {
//           _tabController = TabController(
//             initialIndex: _tabController.index,
//             length: state.category.length + 1,
//             vsync: this,
//           );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           key: _scaffoldKey,
//           drawer: DrawerHome(),
//           body: SafeArea(
//             bottom: false,
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           _scaffoldKey.currentState?.openDrawer();
//                         },
//                         icon:
//                             Icon(MoonIcons.generic_burger_regular_16_regular)),
//                     Spacer(),
//                     MoonDropdown(
//                       contentPadding: EdgeInsets.zero,
//                       maxWidth: 130, // ✅ already good — limits width
//                       onTapOutside: () {
//                         bloc.add(ClickOutsiteCreatePost());
//                       },
//                       show: state.showPost,
//                       content: Container(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment:
//                               CrossAxisAlignment.start, // optional alignment
//                           children: [
//                             MoonButton(
//                               leading: Icon(MoonIcons.generic_edit_16_regular),
//                               label: Text(t.common.question),
//                               onTap: () {
//                                 bloc.add(ClickPostQuestion());
//                               },
//                             ),
//                             SizedBox(height: 8),
//                             MoonButton(
//                               leading: Icon(MoonIcons.chat_chat_16_regular),
//                               label: Text(t.discussion.title),
//                               onTap: () {
//                                 bloc.add(ClickPostDiscussion());
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       child: MoonButton.icon(
//                         onTap: () {
//                           bloc.add(ClickPost());
//                         },
//                         icon: Icon(MoonIcons.controls_plus_16_regular),
//                       ),
//                     ),
//                     MoonButton.icon(
//                       onTap: () {
//                         bloc.add(ClickSearch());
//                       },
//                       icon: Icon(MoonIcons.generic_search_16_regular),
//                     ),
//                     kPadding2.gap,
//                   ],
//                 ),
//                 TabBar(
//                   unselectedLabelStyle: context.moonTypography!.body.text16,
//                   splashFactory: NoSplash.splashFactory,
//                   tabAlignment: TabAlignment.start,
//                   padding: EdgeInsets.zero,
//                   isScrollable: true,
//                   indicatorSize: TabBarIndicatorSize.label,
//                   indicator: UnderlineTabIndicator(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide:
//                         BorderSide(width: 3, color: context.moonColors!.bulma),
//                   ),
//                   controller: _tabController,
//                   labelStyle: context.moonTypography!.heading.text16
//                       .copyWith(color: context.moonColors!.bulma),
//                   tabs: [
//                     Tab(text: t.homeScreen.title),
//                     ...List.generate(state.category.length, (index) {
//                       final subject = state.category[index];
//                       return Tab(
//                         text: "${subject.name}",
//                       );
//                     })
//                   ],
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       NotificationListener<ScrollUpdateNotification>(
//                         onNotification: (notification) {
//                           if (_scaffoldWithNavbarBloc.scrollController.position
//                                   .userScrollDirection ==
//                               ScrollDirection.reverse) {
//                             _scaffoldWithNavbarBloc.add(
//                                 ScrollDirectionUpdateEvent(
//                                     isScrollingDown: false));
//                           } else if (_scaffoldWithNavbarBloc.scrollController
//                                   .position.userScrollDirection ==
//                               ScrollDirection.forward) {
//                             _scaffoldWithNavbarBloc.add(
//                                 ScrollDirectionUpdateEvent(
//                                     isScrollingDown: true));
//                           }
//                           return true;
//                         },
//                         child: AppSmartRefreshScrollView(
//                           enableLoadMore: state.isMorePage,
//                           onLoadMore: () async {
//                             if (bloc.state.isMorePage) {
//                               bloc.add(GetQuestionEvent());
//                             }
//                           },
//                           onRefresh: () async {
//                             bloc.add(RefreshPage());
//                           },
//                           child: state.questions.isEmpty
//                               ? SingleChildScrollView(
//                                   controller:
//                                       _scaffoldWithNavbarBloc.scrollController,
//                                   child: HomeShimmer())
//                               : ListView.separated(
//                                   padding: EdgeInsets.only(
//                                       bottom: MediaQuery.of(context)
//                                           .padding
//                                           .bottom),
//                                   controller:
//                                       _scaffoldWithNavbarBloc.scrollController,
//                                   itemBuilder: (context, index) {
//                                     final question = state.questions[index];
//                                     return CustomQuestionCard(
//                                       longPressEnd: (value) async {
//                                         if (value == actionEnum.share) {
//                                           bloc.add(ShareQuestion(question));
//                                         }
//                                         if (value == actionEnum.like) {
//                                           bloc.add(ClickLikeEvent(index));
//                                         }
//                                         if (value == actionEnum.hide) {
//                                           bloc.add(ClickHideEvent(index));
//                                         }
//                                         if (value == actionEnum.save) {
//                                           if (question.is_saved) {
//                                             bloc.add(ClickSaveQuestion(index));
//                                           } else {
//                                             bool save =
//                                                 await showModalBottomSheet(
//                                               context: context,
//                                               isScrollControlled: true,
//                                               useSafeArea: true,
//                                               builder: ((context) {
//                                                 return SaveQuestionToCategoryPage(
//                                                   questionId: question.id,
//                                                 );
//                                               }),
//                                             );
//                                             if (save) {
//                                               bloc.add(
//                                                   ClickSaveQuestion(index));
//                                             }
//                                           }
//                                         }
//                                       },
//                                       onDoubleTap: () {
//                                         bloc.add(ClickDoubleTapEvent(index));
//                                       },
//                                       onTapLike: () {
//                                         bloc.add(ClickLikeEvent(index));
//                                       },
//                                       onTapUnHide: () {
//                                         bloc.add(ClickUnHideEvent(index));
//                                       },
//                                       questionEntity: question,
//                                       onPressed: () async {
//                                         bloc.add(ClickQuestionEvent(
//                                             question.id, question));
//                                       },
//                                     );
//                                   },
//                                   separatorBuilder: (_, index) =>
//                                       AppDivider.normal(),
//                                   itemCount: state.questions.length,
//                                 ),
//                         ),
//                       ),
//                       ...List.generate(
//                         state.category.length,
//                         (index) => AllBookPage(index: index),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
