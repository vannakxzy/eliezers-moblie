// import 'package:auto_route/annotations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:moon_design/moon_design.dart';

// import '../../../../app/base/page/base_page_bloc_state.dart';
// import '../../../../app/global_notify_bloc/global_notify_bloc.dart';
// import '../../../../config/router/page_route/app_route_info.dart';
// import '../../../../core/constants/constants.dart';
// import '../../../../core/utils/widgets/custom_avata.dart';
// import '../../../../core/utils/widgets/custom_loading.dart';
// import '../../../../gen/i18n/translations.g.dart';
// import '../../../../shared/widgets/app_refresh_indicator.dart';
// import '../bloc/bloc.dart';
// import '../bloc/bloc/manage_band_bloc.dart' show ManageBandState;
// import '../widgets/band_tab_widget.dart';
// import 'band_pendding_page.dart';
// import 'member_request_page.dart';

// @RoutePage()
// class bandPage extends StatefulWidget {
//   const bandPage({super.key});

//   @override
//   State<bandPage> createState() => _bandPageState();
// }

// class _bandPageState extends BasePageBlocState<bandPage, bandBloc>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   @override
//   void initState() {
//     bloc.add(InitPage());
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(() {
//       bloc.add(TabChanged(_tabController.index));
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget buildPage(BuildContext context) {
//     return GlobalBlocListener<ManageBandState>(
//       onListen: (context, state) {
//         debugPrint('Global State: $state');
//       },
//       child: BlocBuilder<bandBloc, BandState>(
//         builder: (context, state) {
//           return Scaffold(
//               body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 0),
//               child: Column(
//                 children: [
                  // Row(
                  //   children: [
                  //     kPadding.gap,
                  //     Text(t.band.title,
                  //         style: context.moonTypography!.heading.text20),
                  //     Spacer(),
                  //     MoonButton(
                  //       leading: Icon(MoonIcons.generic_search_24_regular),
                  //       onTap: () {
                  //         appRoute.push(AppRouteInfo.resultSearch('', 2));
                  //       },
                  //     ),
                  //     MoonButton(
                  //       onTap: () {
                  //         bloc.add(ClickCreateband());
                  //       },
                  //       leading: Icon(
                  //         MoonIcons.controls_plus_24_regular,
                  //       ),
                  //     ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 40,
//                     child: TabBar(
//                         controller: _tabController,
//                         splashFactory: NoSplash.splashFactory, // Disable splash
//                         overlayColor:
//                             MaterialStateProperty.all(Colors.transparent),
//                         tabAlignment: TabAlignment.start,
//                         isScrollable: true,
//                         labelColor: context.moonColors!.bulma,
//                         indicator: UnderlineTabIndicator(
//                           borderSide: BorderSide(
//                               width: 3, color: context.moonColors!.piccolo),
//                         ),
//                         tabs: [
//                           BandTabWidget(
//                               isActive: state.pageIndex == 0 ? true : false,
//                               label: t.band.action),
//                           BandTabWidget(
//                               isActive: state.pageIndex == 1 ? true : false,
//                               label: t.band.pendding),
//                           BandTabWidget(
//                               isActive: state.pageIndex == 2 ? true : false,
//                               label: t.band.request),
//                         ]),
//                   ),
//                   Expanded(
//                       child: TabBarView(controller: _tabController, children: [
//                     AppSmartRefreshScrollView(
//                       enableLoadMore: state.isMorePage,
//                       onRefresh: () async {
//                         bloc.add(RefreshPage());
//                       },
//                       onLoadMore: () async {
//                         bloc.add(InitPage());
//                       },
//                       child: state.isLoading && state.band.isEmpty
//                           ? Center(
//                               child: CustomLoading(),
//                             )
//                           : state.band.isEmpty
//                               ? Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(t.band.noDateMes),
//                                     kPadding.gap,
//                                     MoonButton(
//                                       buttonSize: MoonButtonSize.sm,
//                                       backgroundColor:
//                                           context.moonColors!.piccolo,
//                                       label: Text(
//                                         t.common.exploreNnow,
//                                         style: context
//                                             .moonTypography!.heading.text14
//                                             .copyWith(color: Colors.white),
//                                       ),
//                                       onTap: () {
//                                         appRoute.push(
//                                             AppRouteInfo.resultSearch("", 2));
//                                       },
//                                     )
//                                   ],
//                                 )
//                               : ListView.builder(
//                                   padding: EdgeInsets.zero,
//                                   itemCount: state.band.length,
//                                   itemBuilder: (context, index) {
//                                     final band = state.band[index];
//                                     return Dismissible(
//                                       key: Key("${band.id}"),
//                                       background: Container(
//                                           color: context.moonColors!.jiren,
//                                           alignment: Alignment.centerRight,
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 20),
//                                           child: Text(
//                                             t.common.leave,
//                                             style: context
//                                                 .moonTypography!.body.text14
//                                                 .copyWith(color: Colors.white),
//                                           )),
//                                       direction: DismissDirection
//                                           .endToStart, // 👈 Only allow swipe left
//                                       onDismissed: (direction) {
//                                         bloc.add(ClickLeave(index));
//                                       },
//                                       child: MoonMenuItem(
//                                         menuItemPadding: EdgeInsets.only(
//                                             left: kPadding,
//                                             top: kPadding,
//                                             right: kPadding),
//                                         onTap: () {
//                                           bloc.add(Clickband(index));
//                                         },
//                                         label: Row(
//                                           children: [
//                                             CustomAvatar(
//                                               name: band.name,
//                                               high: 60,
//                                               width: 60,
//                                               image: band.image,
//                                             ),
//                                             kPadding.gap,
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   band.name,
//                                                   style: context.moonTypography!
//                                                       .heading.text16,
//                                                   textHeightBehavior:
//                                                       TextHeightBehavior(
//                                                     applyHeightToFirstAscent:
//                                                         false,
//                                                     applyHeightToLastDescent:
//                                                         false,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   "${band.member} ${t.common.member}",
//                                                   style: context.moonTypography!
//                                                       .body.text14
//                                                       .copyWith(
//                                                     color: context
//                                                         .moonColors!.trunks,
//                                                   ),
//                                                   textHeightBehavior:
//                                                       TextHeightBehavior(
//                                                     applyHeightToFirstAscent:
//                                                         false,
//                                                     applyHeightToLastDescent:
//                                                         false,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         trailing: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                               band.updatedAt,
//                                               style: context
//                                                   .moonTypography!.body.text12
//                                                   .copyWith(
//                                                       color: context
//                                                           .moonColors!.trunks),
//                                             ),
//                                             if (band.unread > 0)
//                                               Container(
//                                                 margin: EdgeInsets.only(
//                                                     top: kPadding / 2),
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 4),
//                                                 decoration: BoxDecoration(
//                                                     color: context
//                                                         .moonColors!.piccolo,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             30)),
//                                                 child: Text(
//                                                   "${band.unread}",
//                                                   style: context.moonTypography!
//                                                       .body.text12
//                                                       .copyWith(
//                                                           color: Colors.white),
//                                                 ),
//                                               )
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                     ),
//                     bandPenddingPage(),
//                     MemberRequestPage(),
//                   ])),
//                 ],
//               ),
//             ),
//           ));
//         },
//       ),
//     );
//   }
// }
