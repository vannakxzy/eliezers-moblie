import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_show_image_file.dart';

import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/constants/constants.dart';
import '../../../gen/i18n/translations.g.dart';
import '../presentation/bloc/category_bloc.dart';
import 'bloc/edit_category_bloc.dart';

class EditCategoryScreen extends StatefulWidget {
  final int categoryIndex;
  final CategoryBloc categoryBloc;

  const EditCategoryScreen({
    super.key,
    required this.categoryIndex,
    required this.categoryBloc,
  });

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState
    extends BasePageBlocState<EditCategoryScreen, EditCategoryBloc> {
  @override
  void initState() {
    final category = widget.categoryBloc.state.category[widget.categoryIndex];
    debugPrint("$category");
    bloc.add(GetDefault(category));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<EditCategoryBloc, EditCategoryState>(
      builder: (context, state) {
        return Scaffold(
            // backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              title: t.common.update,
              isClose: true,
            ),
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: kBorderWidthSmall,
                            color: context.moonColors!.trunks))),
                padding: kScreenPadding,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "${t.common.title}...",
                        ),
                        onChanged: (value) {
                          bloc.add(
                            BookNameChangedEvent(value),
                          );
                        },
                        controller: bloc.state.bookNameText,
                      ),
                      state.fileCover != null || state.urlCover.isNotEmpty
                          ? CustomCoverBook(
                              imageUrl: state.urlCover,
                              file: state.fileCover,
                              ontapClearImage: () {
                                bloc.add(
                                  ClickClearCoverEvent(),
                                );
                              },
                              ontapPickImage: () {
                                bloc.add(ClickPickCoverEvent());
                              },
                            )
                          : GestureDetector(
                              onTap: () {
                                bloc.add(ClickPickCoverEvent());
                              },
                              child: const Icon(
                                  MoonIcons.generic_picture_24_light),
                            ),
                      const Gap(kPadding2),
                      const Spacer(),
                      MoonButton(
                        isFullWidth: true,
                        buttonSize: MoonButtonSize.md,
                        textColor: Colors.white,
                        backgroundColor: context.moonColors!.piccolo
                            .withOpacity(!state.enableBotton ? 0.3 : 1),
                        label: state.isLoading
                            ? const MoonCircularLoader(
                                sizeValue: 20,
                                color: Colors.white,
                              )
                            : Text(t.common.update.toUpperCase()),
                        onTap: () {
                          if (state.enableBotton) {
                            bloc.add(ClickUpdate(state.category!.id));
                          }
                        },
                      ),
                    ]),
              ),
            ));
      },
    );
  }
}
