import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../domain/entities/bible_content_entity.dart';
import '../bloc/bloc/bible_book_bloc.dart';
import 'bible_controller.dart';

@RoutePage()
class BibleBookPage extends StatefulWidget {
  const BibleBookPage({super.key});

  @override
  State<BibleBookPage> createState() => _BibleBookPageState();
}

class _BibleBookPageState
    extends BasePageBlocState<BibleBookPage, BibleBookBloc> {
  late final BibleController bibleController;

  late final List<BibleContentEntity> bible;

  final List<ExpansionTileController> controllers = [];

  @override
  void initState() {
    super.initState();

    bibleController = Get.find<BibleController>();

    bible = bibleController.bible;

    controllers.addAll(
      List.generate(
        bible.length,
        (_) => ExpansionTileController(),
      ),
    );
  }

  @override
  void dispose() {
    controllers.clear();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.bible.title),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: kPadding2,
          ),
          itemCount: bible.length,
          itemBuilder: (context, index) {
            final data = bible[index];

            return ExpansionTile(
              key: PageStorageKey<String>(
                'bible_book_${data.id}',
              ),
              controller: controllers[index],
              shape: const Border(),
              collapsedShape: const Border(),
              enableFeedback: false,
              tilePadding: EdgeInsets.zero,
              maintainState: false,
              onExpansionChanged: (expanded) {
                if (!expanded) return;
                for (int i = 0; i < controllers.length; i++) {
                  if (i != index && controllers[i].isExpanded) {
                    controllers[i].collapse();
                  }
                }
              },
              title: Text(
                data.full_title,
                style: context.moonTypography!.heading.text18,
              ),
              children: [
                GridView.builder(
                  key: PageStorageKey<String>(
                    'chapter_grid_${data.id}',
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: kPadding,
                    mainAxisSpacing: kPadding,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: data.chapters.length,
                  itemBuilder: (context, chapterIndex) {
                    final chapter = data.chapters[chapterIndex];
                    return MoonButton(
                      padding: EdgeInsets.all(kPadding),
                      backgroundColor: context.moonColors!.beerus,
                      borderRadius: BorderRadius.circular(kRadius),
                      buttonSize: MoonButtonSize.xl,
                      onTap: () {
                        debugPrint('Bible Index: $index');
                        debugPrint('Chapter Index: $chapterIndex');
                        Navigator.pop(context, {
                          'index': index,
                          'chapterIndex': chapterIndex,
                        });
                      },
                      label: Text(
                        chapter.title,
                        style: context.moonTypography!.body.text14,
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
