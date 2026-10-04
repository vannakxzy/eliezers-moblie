import 'package:flutter/material.dart';
import '../../../core/utils/widgets/custom_question_card.dart';
import '../../home/domain/entities/question_entity.dart';

import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../gen/i18n/translations.g.dart';

class PostQuestionPreview extends StatefulWidget {
  final QuestionEntity questionEntity;
  const PostQuestionPreview({super.key, required this.questionEntity});

  @override
  State<PostQuestionPreview> createState() => _PostQuestionPreviewState();
}

class _PostQuestionPreviewState extends State<PostQuestionPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t.post.previewTitle,
      ),
      body: SingleChildScrollView(
        child: IgnorePointer(
          ignoring: true,
          child: CustomQuestionCard(
              onDoubleTap: (vaue) {},
              onPressed: () {},
              questionEntity: widget.questionEntity,
              longPressEnd: (value) {}),
        ),
      ),
    );
  }
}
