import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/widgets/custom_buttom.dart';
import 'package:moon_design/moon_design.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_show_image_file.dart';

import '../../../../gen/i18n/translations.g.dart';
import '../../../core/helper/fuction.dart';
import 'bloc/create_category_bloc.dart';

@RoutePage()
class CreateCategoryPage extends StatefulWidget {
  final int questionId;
  const CreateCategoryPage({super.key, required this.questionId});

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState
    extends BasePageBlocState<CreateCategoryPage, CreateCategoryBloc> {
  FocusNode myFocusNode = FocusNode();
  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<CreateCategoryBloc, CreateCategoryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: t.book.createBook,
            isClose: true,
          ),
          body: SafeArea(
            child: Container(
              margin: kScreenPadding,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            focusNode: myFocusNode,
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "${t.common.title}.....",
                            ),
                            onChanged: (value) {
                              bloc.add(
                                BookNameChangedEvent(value),
                              );
                            },
                          ),
                          state.bookCover != null
                              ? CustomCoverBook(
                                  file: state.bookCover,
                                  ontapClearImage: () {
                                    bloc.add(
                                      ClickClearCoverEvent(),
                                    );
                                  },
                                  ontapPickImage: () async {
                                    unFocus();
                                    final image = await pickImage();
                                    bloc.add(ClickPickCoverEvent(image));
                                    myFocusNode.requestFocus();
                                  },
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    unFocus();
                                    final image = await pickImage();
                                    bloc.add(ClickPickCoverEvent(image));
                                    myFocusNode.requestFocus();
                                  },
                                  child: const Icon(
                                    MoonIcons.generic_picture_24_light,
                                    size: 30,
                                  ),
                                ),
                        ]),
                  ),
                  CustomButtom(
                    isFullWidth: true,
                    buttonSize: MoonButtonSize.md,
                    isloading: state.isloading,
                    disable: !state.enableBotton,
                    title: t.common.create.toUpperCase(),
                    onTap: () {
                      if (state.enableBotton) {
                        bloc.add(ClickCreateEvent(widget.questionId, context));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
