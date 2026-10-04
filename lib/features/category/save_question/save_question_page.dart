import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/constants/size_constant.dart';
import '../../../core/utils/widgets/custom_book.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../../shared/widgets/app_refresh_indicator.dart';
import '../create_category/create_category_page.dart';
import 'bloc/save_question_bloc.dart';

class SaveQuestionToCategoryBottomSheet {
  static Future<bool?> show({
    required BuildContext context,
    required int questionId,
  }) {
    return showMoonModalBottomSheet<bool>(
      context: context,
      enableDrag: true,
      height: MediaQuery.of(context).size.height * 0.9,
      borderRadius: BorderRadius.circular(30),
      builder: (context) {
        return SaveQuestionPage(questionId: questionId);
      },
    );
  }
}

class SaveQuestionPage extends StatefulWidget {
  final int questionId;
  const SaveQuestionPage({super.key, required this.questionId});

  @override
  State<SaveQuestionPage> createState() => _SaveQuestionToCategoryState();
}

class _SaveQuestionToCategoryState
    extends BasePageBlocState<SaveQuestionPage, SaveQuestionBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(GetCategoryEvent());
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kPadding.gap,
            SizedBox(
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Centered title
                  Center(
                    child: Text(
                      t.book.saveQuestion,
                      style: context.moonTypography!.heading.text16,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Right-aligned close button
                  Positioned(
                    right: kPadding2,
                    child: MoonButton.icon(
                      // backgroundColor: context.moonColors!.beerus,
                      borderRadius: BorderRadius.circular(50),
                      icon: const Icon(MoonIcons.controls_close_24_regular),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
            kPadding.gap,
            BlocBuilder<SaveQuestionBloc, SaveQuestionState>(
              builder: (context, state) {
                if (state.isloading && state.category.isEmpty) {
                  return const Expanded(child: Center(child: CustomLoading()));
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding2),
                    child: AppSmartRefreshScrollView(
                      onRefresh: () async {
                        bloc.add(GetCategoryEvent());
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.category.length,
                        itemBuilder: (context, index) {
                          final book = state.category[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (index == 0)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: kPadding),
                                  child: Text(t.book.yourBook),
                                ),
                              GestureDetector(
                                onTap: () {
                                  bloc.add(CreateSaveQuestionToCategory(
                                    categoryId: book.id,
                                    questionId: widget.questionId,
                                  ));
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(bottom: kPadding2),
                                  child: Row(
                                    children: [
                                      CustomBook(
                                        image: book.cover ?? "",
                                        height: 60,
                                        width: 45,
                                        title: "",
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          book.name ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            GestureDetector(
              onTap: () async {
                final done = await showModalBottomSheet<bool>(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (_) => CreateCategoryPage(
                    questionId: widget.questionId,
                  ),
                );
                if (done == true) {
                  Navigator.pop(context, true);
                }
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.moonColors!.piccolo,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Gap(kPadding),
                    Text(
                      t.book.createBook,
                      style: context.moonTypography!.heading.text16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
