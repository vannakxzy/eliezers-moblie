import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/base/page/base_page_bloc_state.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_disable_widget_wrapper.dart';
import '../../../core/utils/widgets/custom_input_textfield.dart';
import 'bloc/post_question_bloc.dart';

class PostQuestion extends StatefulWidget {
  const PostQuestion({super.key});

  @override
  State<PostQuestion> createState() => _PostQuestionState();
}

class _PostQuestionState
    extends BasePageBlocState<PostQuestion, PostQuestionBloc> {
  @override
  bool get wantKeepAlive => true;

  @override
  bool get globalBloc => true;

  @override
  Widget buildPage(BuildContext context) {
    bloc;
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding2,
        vertical: kPadding2,
      ),
      children: [
        CustomInfoTextfield(
          labelText: "ចំណងជើង",
          hintText: 'Add a title . . .',
          onChanged: (value) {
            // bloc.add(PostEvent.titleChanged(title: value));
          },
          // controller: state.titleTextEditController,
          // maxLines: 1,
        ),
        const Gap(kPadding2),
        DisableWrapper(
          absorbing: false,
          // absorbing: !state.title.isNotEmptyOrNull,
          child: CustomInfoTextfield(
            height: 200,
            labelText: "ពន្យល់",
            hintText: 'Add a description . . .',
            onChanged: (value) {
              debugPrint(value);
              // bloc.add(PostEvent.descriptionChanged(des: value));
            },
            // controller: state.descriptionTextController,
          ),
        ),
        const Gap(kPadding2),
        DisableWrapper(
          absorbing: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomInfoTextfield(
                labelText: 'Tags',
                hintText:
                    'Add some tags people will easily reach your post . . .',
              ),
              Container(
                margin: const EdgeInsets.only(bottom: kPadding),
                child: const Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  children: [
                    // ...bloc.state.selectTags.asMap().entries.map(
                    //   (element) {
                    //     return CustomTagCard(
                    //       isOnSearch: false,
                    //       title: element.value.name,
                    //       ontap: () {
                    //         // bloc.add(PostEvent.onClickRemoveTag(
                    //         //     index: element.key));
                    //       },
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // if (state.image != null)
        // Padding(
        //   padding: const EdgeInsets.only(top: kPadding2),
        //   child: Stack(
        //     children: [
        //       // Image.file(
        //       //   state.image!,
        //       //   width: double.infinity,
        //       // ),
        //       Positioned(
        //         top: 5,
        //         right: 5,
        //         child: GestureDetector(
        //           onTap: () {
        //             // bloc.add(const PostEvent.clearImage());
        //           },
        //           child: Container(
        //             height: 20,
        //             width: 20,
        //             decoration: BoxDecoration(
        //                 color: Theme.of(context)
        //                     .colorScheme
        //                     .primary
        //                     .withOpacity(0.4),
        //                 borderRadius: BorderRadius.circular(20)),
        //             child: const Center(
        //               child: Icon(
        //                 Icons.close,
        //                 color: Colors.white,
        //                 size: 16,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
