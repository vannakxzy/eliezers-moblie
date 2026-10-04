import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/router/page_route/app_route_info.dart';
import '../../constants/icon_constant.dart';
import '../../extension/string_extension.dart';
import '../controllers/app_controller.dart';
import 'custom_anonymous_card.dart';
import 'custom_cache_image_cricle.dart';
import 'custom_tag_card.dart';
import '../../../di/di.dart';
import '../../../features/home/domain/entities/question_entity.dart';
import '../../../features/setting/bottomsheet/profile_buttonsheet.dart';
import 'package:moon_design/moon_design.dart';

import '../../../app/base/navigation/app_navigator.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../constants/constants.dart';
import '../../helper/local_data/storge_local.dart';

class CustomDiscussion extends StatefulWidget {
  final QuestionEntity discussion;
  final Function onPressed;
  final Function onDoubleTap;
  final Function? onTapUnHide;
  final ValueChanged<actionEnum> longPressEnd;
  final bool anonymous;
  final Function? onTapLike;
  final String textHighlight;

  const CustomDiscussion({
    super.key,
    this.textHighlight = '',
    this.anonymous = false,
    required this.onDoubleTap,
    required this.onPressed,
    required this.discussion,
    required this.longPressEnd,
    this.onTapUnHide,
    this.onTapLike,
  });

  @override
  State<CustomDiscussion> createState() => _CustomDiscussionState();
}

class _CustomDiscussionState extends State<CustomDiscussion>
    with SingleTickerProviderStateMixin {
  final appController = Get.put(AppController());
  TransformationController controller = TransformationController();
  AnimationController? animationController;
  Animation<Matrix4>? animation;
  OverlayEntry? empty;

  @override
  void initState() {
    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )
      ..addListener(() {
        controller.value = animation!.value;
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          removeOverlay(context);
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            widget.onPressed();
          },
          onLongPressStart: (value) {
            appController.onlongPressStart(
              saved: widget.discussion.is_saved,
              golbalDx: value.globalPosition.dx,
              golbalDy: value.globalPosition.dy,
              widthScreen: MediaQuery.sizeOf(context).width,
              id: widget.discussion.id,
            );
          },
          onLongPressMoveUpdate: (value) {
            appController.onLongPressMoveUpdate(
                globalDx: value.globalPosition.dx - 22,
                globalDy: value.globalPosition.dy - 22);
          },
          onLongPressEnd: (value) {
            actionEnum i = appController.onLongPressEnd(context);
            if (token.isEmpty && i != actionEnum.share) {
              Future.delayed(
                const Duration(milliseconds: 200),
                () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CustomAnonymousCard();
                    },
                  );
                },
              );
            } else {
              widget.longPressEnd(i);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: kPadding),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: kPadding / 2,
                    // left: kPadding,
                    // right: kPadding,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.discussion.title.isNotEmpty)
                                  Text(
                                    widget.discussion.title,
                                    style: context
                                        .moonTypography!.heading.text16
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                if (widget
                                    .discussion.description.isNotEmptyOrNull)
                                  HighlightText(
                                    fullText: widget.discussion.description,
                                    searchText: widget.textHighlight,
                                  ),
                              ],
                            ),
                          ),
                          buildimage(),
                          IgnorePointer(
                            ignoring: true,
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: kPadding,
                                left: kPadding,
                                right: kPadding,
                              ),
                              child: Wrap(
                                runSpacing: kPadding,
                                spacing: kPadding,
                                children: widget.discussion.tags
                                    .map(
                                      (tag) => CustomTagCard(title: tag.name),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          kPadding,
                          kPadding,
                          kPadding,
                          kPadding,
                        ),
                        child: Row(
                          children: [
                            MoonTag(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: context.moonColors!.beerus,
                                ),
                                borderRadius: BorderRadius.circular(kRadius2),
                              ),
                              label: Text(
                                "${widget.discussion.amountAnswers}",
                                style: context.moonTypography!.body.text12
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: context.moonColors!.trunks),
                              ),
                              leading: Icon(
                                size: 18,
                                MiconComment,
                                color: context.moonColors!.trunks,
                              ),
                            ),
                            kPadding.gap,
                            MoonTag(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: context.moonColors!.beerus,
                                ),
                                borderRadius: BorderRadius.circular(kRadius2),
                              ),
                              onTap: () {
                                if (token.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const CustomAnonymousCard();
                                    },
                                  );
                                } else {
                                  widget.onTapLike!();
                                }
                              },
                              borderRadius: BorderRadius.circular(kRadius2),
                              label: Row(
                                children: [
                                  Text(
                                    "${widget.discussion.countLike}",
                                    style: context.moonTypography!.body.text12
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: widget.discussion.is_like
                                                ? AppColor.successColor
                                                : context.moonColors!.trunks),
                                  ),
                                ],
                              ),
                              leading: Icon(MiconLike,
                                  size: 18,
                                  color: widget.discussion.is_like
                                      ? AppColor.successColor
                                      : context.moonColors!.trunks),
                            ),
                            if (widget.discussion.is_saved)
                              Row(
                                children: [
                                  kPadding.gap,
                                  MoonTag(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.5,
                                        color: context.moonColors!.beerus,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(kRadiusMax),
                                    ),
                                    padding: EdgeInsets.zero,
                                    label: Icon(
                                      MoonIcons.generic_bookmark_24_regular,
                                      color: context.moonColors!.trunks,
                                    ),
                                  ),
                                ],
                              ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      getIt.get<IAppNavigator>().push(
                                          AppRouteInfo.otherProfile(
                                              userId:
                                                  widget.discussion.userId));
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Text(
                                        "${widget.discussion.name}  .",
                                        style: context
                                            .moonTypography!.body.text12
                                            .copyWith(
                                                color:
                                                    context.moonColors!.trunks),
                                      ),
                                    ),
                                  ),
                                  kPadding.gap,
                                  Text(
                                    widget.discussion.date,
                                    style: context.moonTypography!.body.text10
                                        .copyWith(
                                            color: context.moonColors!.trunks),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.discussion.isHide)
                  Positioned.fill(
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          ClipPath(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 20.0, sigmaY: 5.0),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: kPadding),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(kRadius2),
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(kPadding2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  t.discussion.hideMessage,
                                  style: context.moonTypography!.body.text14
                                      .copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                kPadding.gap,
                                MoonButton(
                                  buttonSize: MoonButtonSize.xs,
                                  backgroundColor: context.moonColors!.beerus,
                                  textColor: context.moonColors!.trunks,
                                  label: Text(t.common.undo),
                                  onTap: () {
                                    widget.onTapUnHide!();
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildimage() {
    return Builder(
      builder: (context) {
        return widget.discussion.file != null || widget.discussion.image != ''
            ? Container(
                margin: const EdgeInsets.only(top: kPadding),
                child: widget.discussion.file == null
                    ? CustomCachedImageCircle(
                        image: widget.discussion.image,
                        borderRadius: BorderRadius.zero,
                      )
                    : Image.file(widget.discussion.file!),
              )
            : const SizedBox.shrink();
      },
    );
  }

  void removeOverlay(BuildContext context) {
    empty?.remove();
    empty = null;
  }
}

class HighlightText extends StatelessWidget {
  final String fullText;
  final String searchText;

  // Constructor to accept fullText and searchText
  const HighlightText({super.key, this.fullText = "", this.searchText = ""});

  @override
  Widget build(BuildContext context) {
    // If searchText is empty, just return the full text without highlighting
    if (searchText.isEmpty) {
      return Text(
        fullText,
        style: context.moonTypography!.body.text14.copyWith(
            // color: context.moonColors!.bulma,
            ),
      );
    }

    List<InlineSpan> textSpans = [];
    int start = 0;

    while (start < fullText.length) {
      int index = fullText.indexOf(searchText, start);

      if (index == -1) {
        // Add the remaining text if no match
        textSpans.add(TextSpan(
          text: fullText.substring(start),
          style: context.moonTypography!.body.text14.copyWith(
              // color: context.moonColors!.bulma,
              ),
        ));
        break;
      }

      // Add text before the match
      if (index > start) {
        textSpans.add(TextSpan(
          text: fullText.substring(start, index),
          style: context.moonTypography!.body.text14.copyWith(
              // color: context.moonColors!.bulma,
              ),
        ));
      }

      // Add the highlighted match with consistent size and alignment
      textSpans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: Text(
            fullText.substring(index, index + searchText.length),
            style: context.moonTypography!.body.text14.copyWith(
              color: context.moonColors!.piccolo,
            ),
          ),
        ),
      );

      start = index + searchText.length;
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
        style: context.moonTypography!.body.text14.copyWith(
          color: context.moonColors!.bulma, // Default text style
        ),
      ),
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      ),
    );
  }
}
