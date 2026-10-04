import 'package:flutter/material.dart';

import '../../../../core/constants/size_constant.dart';
import '../../../../core/utils/widgets/custom_textfield.dart';
import '../../domain/entities/tag_entity.dart';

import '../../../../core/utils/widgets/custom_tag_card.dart';

class TagTextField extends StatefulWidget {
  const TagTextField({
    super.key,
    required this.tags,
    this.onTappedTag,
    this.title,
  });
  final String? title;
  final List<TagEntity> tags;
  final ValueChanged<TagEntity>? onTappedTag;

  @override
  State<TagTextField> createState() => _TagTextFieldState();
}

class _TagTextFieldState extends State<TagTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty) ...[
          Text(
            widget.title!,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          kPadding.gap,
        ],
        SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: kPadding,
            runSpacing: kPadding,
            children: [
              ...widget.tags.map(
                (tag) => CustomTagCard(
                  isOnSearch: false,
                  title: tag.name,
                  ontap: () {
                    widget.onTappedTag?.call(tag);
                  },
                ),
              )
            ],
          ),
        ),
        kPadding.gap,
        const CustomTextfield(),
      ],
    );
  }
}
