
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../di/di.dart';
import '../../../bottom_navigationbar/controller/scroll_visibility_controller.dart';
import '../bloc/bloc.dart';
import '../bloc/bloc/bible_book_bloc.dart';
import '../widgets/BibleChapterRenderer.dart';
import 'bible_book_page.dart';
import 'bible_controller.dart';

@RoutePage()
class BiblePage extends StatefulWidget {
  const BiblePage({super.key});

  @override
  State<BiblePage> createState() => _BiblePageState();
}

class _BiblePageState extends BasePageBlocState<BiblePage, BibleBloc> {
  late final BibleBookBloc bibleBookBloc;
  final controller = Get.put(BibleController());
final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    bloc.add(InitPage());
    _scrollController.addListener(_onScroll);

    bibleBookBloc = getIt<BibleBookBloc>();
  }
  @override
  void dispose() {
    bibleBookBloc.close();
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final direction = _scrollController.position.userScrollDirection;

    if (direction == ScrollDirection.reverse) {
      ScrollVisibilityController.showBottomNav.value = false;
    } else if (direction == ScrollDirection.forward) {
      ScrollVisibilityController.showBottomNav.value = true;
    }
  }
  
  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<BibleBloc, BibleState>(
      builder: (context, state) {
        if (state.isloading || state.bible.isEmpty) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return ValueListenableBuilder<bool>(
          valueListenable: ScrollVisibilityController.showBottomNav,
          builder: (context, show, child) => Container(
            // padding: EdgeInsets.symmetric(horizontal: kPadding2),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: kPadding2),
                      child: Column(
                        children: [
                          ClipRect(
                            child: AnimatedContainer(
                              height: show ? 50 : 0,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              child: IgnorePointer(
                                ignoring: !show,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MoonButton.icon(
                                      onTap: () {},
                                      icon:
                                          Icon(MoonIcons.maps_world_24_regular),
                                    ),
                                    MoonButton.icon(
                                      onTap: () {},
                                      icon:
                                          Icon(MoonIcons.maps_world_24_regular),
                                    ),
                                    MoonButton.icon(
                                      onTap: () {},
                                      icon:
                                          Icon(MoonIcons.maps_world_24_regular),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Column(
                                    children: [
                                      Text(
                                        state.bible[state.bibleIndex].title,
                                        style: context
                                            .moonTypography!.heading.text24,
                                      ),
                                      BibleChapterRenderer(
                                        html: state.biblePassageEntity!.content,
                                        onVerseTap: (verse) {
                                          debugPrint('Selected verse: $verse');
                                        },
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top:
                                BorderSide(color: context.moonColors!.beerus))),
                    padding: EdgeInsets.symmetric(
                        vertical: !show ? 0 : kPadding,
                        horizontal: !show ? 0 : kPadding2),
                    child: Row(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          reverseDuration: const Duration(milliseconds: 250),
                          switchInCurve: Curves.easeOutBack,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              axis: Axis.horizontal,
                              axisAlignment: -1,
                              child: FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(-0.5, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              ),
                            );
                          },
                          child: show
                              ? Padding(
                                  key: const ValueKey('back'),
                                  padding: const EdgeInsets.only(
                                      right: kPadding / 2),
                                  child: MoonButton.icon(
                                    borderRadius:
                                        BorderRadius.circular(kRadius),
                                    onTap: () {
                                      bloc.add(ClickBackChapter());
                                    },
                                    buttonSize: MoonButtonSize.lg,
                                    icon: Icon(MoonIcons.arrows_left_24_light),
                                    backgroundColor: context.moonColors!.beerus,
                                  ),
                                )
                              : const SizedBox(
                                  key: ValueKey('empty'),
                                ),
                        ),

                        // Chapter selector
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            child: MoonButton(
                              
                              onTap: () async {
                                controller.getBible(state.bible);
                            
                                final Map<String, dynamic>? result =
                                    await Navigator.push<Map<String, dynamic>>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BibleBookPage(),
                                  ),
                                );

                                if (result != null) {
                                  final int index = result['index'];
                                  final int chapterIndex =
                                      result['chapterIndex'];

                                  bloc.add(
                                    LoadBibleChapter(index, chapterIndex),
                                  );
                                }
                              },
                              isFullWidth: true,
                              buttonSize: MoonButtonSize.lg,
                              borderRadius: BorderRadius.circular(kRadius),
                              backgroundColor: show
                                  ? context.moonColors!.beerus
                                  : Colors.transparent,
                              label: Text(
                                "${state.bible[state.bibleIndex].title} ${state.chapterIndex + 1}",
                              ),
                            ),
                          ),
                        ),

                        // Next button animation
                        AnimatedSwitcher(
                          
                          duration: const Duration(milliseconds: 350),
                          reverseDuration: const Duration(milliseconds: 250),
                          switchInCurve: Curves.easeOutBack,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              axis: Axis.horizontal,
                              axisAlignment: -1,
                              child: FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(-0.5, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              ),
                            );
                          },
                          child: show
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(left: kPadding / 2),
                                  child: MoonButton.icon(
                                    borderRadius:
                                        BorderRadius.circular(kRadius),
                                    onTap: () {
                                      bloc.add(ClickNextChapter());
                                    },
                                    buttonSize: MoonButtonSize.lg,
                                    icon:
                                        Icon(MoonIcons.arrows_right_24_regular),
                                    backgroundColor: context.moonColors!.beerus,
                                  ),
                                )
                              : const SizedBox(
                                  key: ValueKey('empty'),
                                ),
                        ),
                      ],
                    ),
)
                ],
              ),
            ),
          ),
        
        );
      },
    );
  }
}
