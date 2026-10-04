import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/utils/widgets/custom_textfield.dart';
import '../../../shared/widgets/app_text.dart';

import '../../../core/constants/constants.dart';
import 'bloc/post_topic_bloc.dart';

class PostTopic extends StatefulWidget {
  const PostTopic({super.key});

  @override
  State<PostTopic> createState() => _PostTopicState();
}

class _PostTopicState extends BasePageBlocState<PostTopic, PostTopicBloc> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget buildPage(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding2,
        vertical: kPadding2,
      ),
      children: [
        const CustomTextfield(
          labelText: 'Title',
          // controller: bloc.titleController,
          textInputType: TextInputType.text,
        ),
        const Gap(kPadding2),
        const CustomTextfield(
          labelText: 'Description',
          height: 200,
          expands: true,
          maxLines: null,
          maxLength: null,
          textInputType: TextInputType.text,
        ),
        const Gap(kPadding2),
        GestureDetector(
          onTap: () async {},
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(kRadius),
            ),
            alignment: Alignment.center,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded),
                AppText('Add Image'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
