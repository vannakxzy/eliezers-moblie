
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    bloc.add(InitPage());
    bibleBookBloc = getIt<BibleBookBloc>();
  }

  @override
  void dispose() {
    bibleBookBloc.close();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return InkWell(
      onTap: () {
        // LocalStorage.remove(SharedPreferenceKeys.bible);
        bloc.add(InitPage());
      },
      child: BlocBuilder<BibleBloc, BibleState>(
        builder: (context, state) {
          if (state.isloading || state.bible.isEmpty) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return InkWell(
            onTap: () {
              bloc.add(InitPage());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: kPadding2),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MoonButton.icon(
                            onTap: () {},
                            icon: Icon(MoonIcons.maps_world_24_regular),
                          ),
                          MoonButton.icon(
                            onTap: () {},
                            icon: Icon(MoonIcons.maps_world_24_regular),
                          ),
                          MoonButton.icon(
                            onTap: () {},
                            icon: Icon(MoonIcons.maps_world_24_regular),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                      children: [
                        Text(
                          state.bible[state.bibleIndex].title,
                          style: context.moonTypography!.heading.text24,
                        ),
                        BibleChapterRenderer(
                          html: state.biblePassageEntity!.content,
                          onVerseTap: (verse) {
                            debugPrint('Selected verse: $verse');
                          },
                        ),
                      ],
                    ))),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: kPadding),
                      child: Row(
                        children: [
                          MoonButton.icon(
                            onTap: () {
                              bloc.add(ClickBackChapter());
                            },
                            buttonSize: MoonButtonSize.lg,
                            icon: Icon(MoonIcons.arrows_left_24_light),
                            backgroundColor: context.moonColors!.beerus,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: kPadding / 2,
                              ),
                              child: MoonButton(
                                padding: EdgeInsets.symmetric(
                                  horizontal: kPadding,
                                ),
                                onTap: () async {
                                  controller.getBible(state.bible);
                                  final Map<String, dynamic>? result =
                                      await Navigator.push<
                                          Map<String, dynamic>>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BibleBookPage(),
                                    ),
                                  );

                                  if (result != null) {
                                    final int index = result['index'];
                                    final int chapterIndex =
                                        result['chapterIndex'];
                                    debugPrint(
                                        "result :::::::::::::::;;; $index");
                                    bloc.add(
                                        LoadBibleChapter(index, chapterIndex));
                                  }
                                },
                                isFullWidth: true,
                                buttonSize: MoonButtonSize.lg,
                                backgroundColor: context.moonColors!.beerus,
                                label: Text(
                                    "${state.bible[state.bibleIndex].title} ${state.chapterIndex + 1}"),
                              ),
                            ),
                          ),
                          MoonButton.icon(
                            onTap: () {
                              bloc.add(ClickNextChapter());
                            },
                            buttonSize: MoonButtonSize.lg,
                            icon: Icon(MoonIcons.arrows_right_24_regular),
                            backgroundColor: context.moonColors!.beerus,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
