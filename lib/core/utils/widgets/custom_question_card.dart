import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../config/router/page_route/app_route_info.dart';
import '../../../gen/assets.gen.dart';
import '../../extension/string_extension.dart';
import '../controllers/app_controller.dart';
import 'custom_anonymous_card.dart';
import 'custom_avata.dart';
import 'custom_cache_image_cricle.dart';
import '../../../di/di.dart';
import '../../../features/home/domain/entities/question_entity.dart';
import '../../../features/setting/bottomsheet/profile_buttonsheet.dart';
import 'package:moon_design/moon_design.dart';

import '../../../app/base/navigation/app_navigator.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../constants/constants.dart';
import '../../helper/local_data/storge_local.dart';

class CustomQuestionCard extends StatefulWidget {
  final QuestionEntity questionEntity;
  final Function onPressed;
  final Function onDoubleTap;
  final Function? onTapUnHide;
  final ValueChanged<actionEnum> longPressEnd;
  final bool anonymous;
  final Function? onTapLike;
  final String textHighlight;

  const CustomQuestionCard({
    super.key,
    this.textHighlight = '',
    this.anonymous = false,
    required this.onDoubleTap,
    required this.onPressed,
    required this.questionEntity,
    required this.longPressEnd,
    this.onTapUnHide,
    this.onTapLike,
  });

  @override
  State<CustomQuestionCard> createState() => _CustomQuestionCardState();
}

class _CustomQuestionCardState extends State<CustomQuestionCard>
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
          // onDoubleTapDown: (detail) {
          //   if (token.isNotEmpty) {
          //     widget.onDoubleTap();
          //     appController.addListLike(detail);
          //   }
          // },
          onTap: () {
            widget.onPressed();
          },
          onLongPressStart: (value) {
            appController.onlongPressStart(
              saved: widget.questionEntity.is_saved,
              golbalDx: value.globalPosition.dx,
              golbalDy: value.globalPosition.dy,
              widthScreen: MediaQuery.sizeOf(context).width,
              id: widget.questionEntity.id,
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
                  padding: const EdgeInsets.only(bottom: kPadding),
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
                                if (widget.questionEntity.title.isNotEmpty)
                                  Text(
                                    widget.questionEntity.title,
                                    style:
                                        context.moonTypography!.heading.text14,
                                  ),
                                if (widget.questionEntity.description
                                    .isNotEmptyOrNull)
                                  HighlightText(
                                    fullText: widget.questionEntity.description,
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
                                spacing: kPadding / 2,
                                children: widget.questionEntity.tags.map(
                                  (tag) {
                                    return MoonTag(
                                        tagSize: MoonTagSize.xs,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: context.moonColors!.beerus
                                              .withOpacity(0.5),
                                        ),
                                        label: Text(
                                          tag.name,
                                          style: context
                                              .moonTypography!.body.text12
                                              .copyWith(
                                            color: context.moonColors!.trunks,
                                          ),
                                        ));
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kPadding,
                            top: kPadding / 2,
                            right: kPadding / 2),
                        child: Row(
                          children: [
                            GestureDetector(
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
                              child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      widget.questionEntity.is_like
                                          ? SvgPicture.asset(
                                              Assets.svg.like.path,
                                              height: 14,
                                              width: 14)
                                          : SvgPicture.asset(
                                              Assets.svg.unlike.path,
                                              color: context.moonColors!.bulma,
                                              height: 14,
                                              width: 14),
                                      Gap(kPadding / 2),
                                      Text("${widget.questionEntity.countLike}",
                                          style: context
                                              .moonTypography!.body.text12)
                                    ],
                                  )),
                            ),
                            kPadding.gap,
                            Row(
                              children: [
                                Icon(
                                    size: 18,
                                    MoonIcons.chat_comment_bubble_24_regular),
                                // Gap(kPadding / 2),
                                Text(
                                  widget.questionEntity.is_discussion
                                      ? " ${widget.questionEntity.amountAnswers}"
                                      : " ${widget.questionEntity.amountComments}",
                                  style: context.moonTypography!.body.text12,
                                )
                              ],
                            ),
                            kPadding.gap,
                            if (!widget.questionEntity.is_discussion)
                              Row(
                                children: [
                                  widget.questionEntity.isTrue
                                      ? SvgPicture.asset(
                                          height: 14,
                                          width: 14,
                                          Assets.svg.star.path)
                                      : SvgPicture.asset(
                                          height: 14,
                                          width: 14,
                                          Assets.svg.unstar.path,
                                          color: context.moonColors!.bulma,
                                        ),
                                  Gap(kPadding / 2),
                                  Text(
                                    "${widget.questionEntity.amountAnswers}",
                                    style: context.moonTypography!.body.text12,
                                  )
                                ],
                              ),
                            if (widget.questionEntity.is_saved)
                              Padding(
                                padding: const EdgeInsets.only(left: kPadding),
                                child: Icon(
                                    size: 17,
                                    MoonIcons.generic_bookmark_24_regular),
                              ),
                            kPadding2.gap,
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      getIt.get<IAppNavigator>().push(
                                          AppRouteInfo.otherProfile(
                                              userId: widget
                                                  .questionEntity.userId));
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          CustomAvatar(
                                              high: 15,
                                              width: 15,
                                              image:
                                                  widget.questionEntity.image),
                                          Gap(5),
                                          Text(
                                            "${widget.questionEntity.name} .",
                                            style: context
                                                .moonTypography!.heading.text12
                                                .copyWith(
                                                    color: context
                                                        .moonColors!.trunks),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Gap(2),
                                  Text(
                                    widget.questionEntity.date,
                                    style: context.moonTypography!.body.text12
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
                if (widget.questionEntity.isHide)
                  Positioned.fill(
                    child: SizedBox(
                      // padding: const EdgeInsets.symmetric(vertical: kPadding),
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
                                  t.common.hideMessage,
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
        return widget.questionEntity.file != null ||
                widget.questionEntity.image != ''
            ? Container(
                margin: const EdgeInsets.only(top: kPadding),
                child: widget.questionEntity.file == null
                    ? CustomCachedImageCircle(
                        image: widget.questionEntity.image,
                        borderRadius: BorderRadius.zero,
                      )
                    : Image.file(widget.questionEntity.file!),
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

  const HighlightText({super.key, this.fullText = "", this.searchText = ""});

  @override
  Widget build(BuildContext context) {
    if (searchText.isEmpty) {
      return Text(
        fullText,
        style: context.moonTypography!.body.text14.copyWith(
          color: context.moonColors!.trunks,
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
            color: context.moonColors!.trunks,
          ),
        ));
        break;
      }

      // Add text before the match
      if (index > start) {
        textSpans.add(TextSpan(
          text: fullText.substring(start, index),
          style: context.moonTypography!.body.text14.copyWith(
            color: context.moonColors!.trunks,
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
          color: context.moonColors!.trunks, // Default text style
        ),
      ),
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      ),
    );
  }
}
