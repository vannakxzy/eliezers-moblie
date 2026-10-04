// ignore_for_file: camel_c'as'e_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/icon_constant.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_anonymous_card.dart';
import '../../../../core/utils/widgets/custom_avata.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../core/utils/widgets/custom_image_file.dart';
import '../../../../gen/i18n/translations.g.dart';

class PostWidget extends StatelessWidget {
  final File? file;
  final String image;
  final String message;
  final String oldMessage;
  final TextEditingController? messageController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<postWidgetEnum> action;
  final bool enablePost;
  final bool postImage;
  final Function? cencalReply;
  final String hintText;
  final bool isReply;
  final String replyTo;
  final FocusNode? focusNode;
  const PostWidget(
      {super.key,
      this.file,
      this.cencalReply,
      this.focusNode,
      this.replyTo = "",
      this.isReply = false,
      this.image = '',
      this.oldMessage = '',
      required this.message,
      required this.messageController,
      this.enablePost = false,
      this.postImage = false,
      this.onChanged,
      this.hintText = '',
      required this.action});

  @override
  Widget build(BuildContext context) {
    final token = LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);
    return GestureDetector(
      onTap: () {
        if (token.isEmpty) {
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAnonymousCard();
            },
          );
        }
      },
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          ignoring: token.isEmpty ? true : false,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border:
                  Border(top: BorderSide(color: context.moonColors!.beerus)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isReply)
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: kPadding),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("${t.common.replyTo}   ",
                                style: context.moonTypography!.body.text12
                                    .copyWith(
                                        color: context.moonColors!.trunks)),
                            Text(replyTo,
                                style:
                                    context.moonTypography!.heading.text14),
                            kPadding.gap,
                            Text("."),
                            kPadding.gap,
                            InkWell(
                              onTap: () {
                                cencalReply!();
                              },
                              child: Text(t.common.cancel,
                                  style: context.moonTypography!.body.text12
                                      .copyWith(
                                          color: context.moonColors!.trunks)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                if (oldMessage.isNotEmpty || image.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.only(
                        top: kPadding, left: kPadding, right: kPadding),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: context.moonColors!.piccolo,
                        ),
                        kPadding.gap,
                        if (image.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(right: kPadding),
                            child: CustomAvatar(
                              image: image,
                              radius: 4,
                            ),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                image.isEmpty
                                    ? t.common.editMessage
                                    : t.common.editPhoto,
                                style: context.moonTypography!.body.text14
                                    .copyWith(
                                        color: context.moonColors!.piccolo),
                              ),
                              Text(
                                oldMessage.isEmpty
                                    ? t.common.photo
                                    : oldMessage,
                                style: context.moonTypography!.body.text12
                                    .copyWith(
                                        color: context.moonColors!.trunks),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            unFocus();
                            action(postWidgetEnum.cancel);
                          },
                          child: Icon(
                            MoonIcons.controls_close_small_24_regular,
                            color: context.moonColors!.trunks,
                          ),
                        ),
                      ],
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((file != null) && postImage == true)
                      Column(
                        children: [
                          kPadding.gap,
                          CustomImageFile(
                            file: file,
                            ontapPickImage: () {
                              action(postWidgetEnum.pickImage);
                            },
                            ontapClearImage: () {
                              action(postWidgetEnum.clearImage);
                            },
                          ),
                          kPadding.gap,
                        ],
                      ),
                    Container(
                      margin: const EdgeInsets.only(bottom: kPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (postImage == true && file == null)
                            GestureDetector(
                              onTap: () {
                                action(postWidgetEnum.pickImage);
                              },
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Icon(
                                    MiconPicture,
                                    color: oldMessage.isNotEmpty ||
                                            image.isNotEmpty
                                        ? context.moonColors!.piccolo
                                        : context.moonColors!.trunks
                                            .withOpacity(0.7),
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: kPadding),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding2, vertical: kPadding),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.6,
                                    color: context.moonColors!.beerus),
                                borderRadius: BorderRadius.circular(25),
                                color: context.moonColors!.gohan,
                              ),
                              child: TextFormField(
                                onTapOutside: (value) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                minLines: 1,
                                style: context.moonTypography!.body.text14
                                    .copyWith(
                                        color: context.moonColors!.trunks),
                                maxLines: 4,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintStyle: context.moonTypography!.body.text14
                                      .copyWith(
                                          color: context.moonColors!.trunks),
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText: hintText,
                                ),

                                keyboardType: TextInputType.multiline,
                                // activeBorderColor: Colors.transparent,
                                // inactiveBorderColor: Colors.transparent,
                                focusNode: focusNode,
                                controller: messageController,

                                onChanged: (value) => onChanged!(value),
                              ),
                            ),
                          ),
                          kPadding.gap,
                          GestureDetector(
                            onTap: () {
                              if (enablePost) {
                                unFocus();
                                if (oldMessage.isNotEmpty || image.isNotEmpty) {
                                  action(postWidgetEnum.edit);
                                } else {
                                  action(postWidgetEnum.postMessage);
                                }
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              height: 40,
                              width: 40,
                              child: Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: enablePost
                                        ? context.moonColors!.piccolo
                                        : context.moonColors!.beerus,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      oldMessage.isNotEmpty || image.isNotEmpty
                                          ? Icons.done_rounded
                                          : Icons.arrow_upward_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum postWidgetEnum {
  cancel,
  edit,
  pickImage,
  clearImage,
  postMessage,
}
