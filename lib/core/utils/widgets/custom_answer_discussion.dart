import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../app/base/navigation/app_navigator.dart';
import '../../../config/router/page_route/app_route_info.dart';
import '../../../data/data_sources/remotes/report_api_service.dart';
import 'package:moon_design/moon_design.dart';
import '../../../di/di.dart';
import '../../../gen/assets.gen.dart';
import '../../constants/constants.dart';
import '../../constants/icon_constant.dart';
import '../../helper/local_data/storge_local.dart';
import 'custom_answer_card.dart';
import 'custom_avata.dart';
import 'custom_cache_image_cricle.dart';
import 'custom_comment_crad.dart';
import 'custom_question_card.dart';

import '../../../features/apps/page/display_image_page.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../../features/profile/domain/entities/answer_entity.dart';
import '../../../features/setting/bottomsheet/answer_buttonsheet.dart';
import 'custom_anonymous_card.dart';

class CustomAnswerDiscussion extends StatefulWidget {
  final AnswertEntity answertEntity;
  final String highlightText;
  final ValueChanged<answerEnum> action;
  final ValueChanged<CommentInAnswerAction>? commentAction;
  final Function? reply;
  final bool tapAll;
  final int answerId;
  final double opacityLike;
  final bool isYourQuestion;
  final bool isCommnity;

  const CustomAnswerDiscussion({
    super.key,
    this.opacityLike = 1,
    required this.answertEntity,
    required this.action,
    this.tapAll = true,
    this.commentAction,
    this.answerId = 0,
    this.reply,
    this.isCommnity = false,
    this.isYourQuestion = false,
    this.highlightText = '',
  });

  @override
  State<CustomAnswerDiscussion> createState() => _CustomAnswerCradState();
}

class _CustomAnswerCradState extends State<CustomAnswerDiscussion> {
  late bool isAnimated;
  final token = LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);

  @override
  void initState() {
    super.initState();
    isAnimated = widget.answertEntity.id == widget.answerId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isAnimated = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: AnimatedOpacity(
          curve: Curves.easeIn,
          opacity: isAnimated ? 1 : 0,
          duration: const Duration(seconds: 2),
          child: Container(
            decoration: BoxDecoration(
              color: context.moonColors!.hit,
            ),
          ),
        )),
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(kPadding),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.action(answerEnum.profile);
                        },
                        child: CustomAvatar(
                          high: 30,
                          width: 30,
                          image: widget.answertEntity.avatar,
                        ),
                      ),
                      kPadding.gap,
                      GestureDetector(
                        onTap: () {
                          widget.action(answerEnum.ontapCard);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "${widget.answertEntity.name} . ",
                                style: context.moonTypography!.heading.text12
                                    .copyWith(
                                        color: context.moonColors!.trunks)),
                            TextSpan(
                                text: "${widget.answertEntity.date} . ",
                                style: context.moonTypography!.heading.text10
                                    .copyWith(
                                        color: context.moonColors!.trunks
                                            .withOpacity(0.7)))
                          ])),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.action(answerEnum.ontapCard);
                  },
                  onLongPress: () {
                    if (widget.tapAll &&
                        widget.answertEntity.isEditDone &&
                        widget.answertEntity.isPostDone) {
                      AnswerButtonsheet.showBottomSheet(
                          context, widget.answertEntity, (value) {
                        widget.action(value);
                      });
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 30,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(top: kPadding),
                                            width: widget.answertEntity
                                                        .amount_comments >
                                                    0
                                                ? 1
                                                : 0,
                                            color: context.moonColors!.beerus,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              kPadding.gap,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (widget
                                        .answertEntity.description.isNotEmpty)
                                      HighlightText(
                                        fullText:
                                            widget.answertEntity.description,
                                        searchText: widget.highlightText,
                                      ),
                                    widget.answertEntity.file != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: kPadding),
                                            child: Image.file(
                                              widget.answertEntity.file!,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : widget.answertEntity.image != ""
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: kPadding),
                                                child: GestureDetector(
                                                  onDoubleTap: () {
                                                    widget.action(
                                                        answerEnum.ontapCard);
                                                  },
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DisplayImagePage(
                                                          isYourImage: widget
                                                              .answertEntity
                                                              .is_your,
                                                          tag: "sdafadsfadsfsd",
                                                          report: ReportInput(
                                                              answer_id: widget
                                                                  .answertEntity
                                                                  .id),
                                                          imageUrl: widget
                                                              .answertEntity
                                                              .image,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Hero(
                                                    tag: "sdafadsfadsfsd",
                                                    child:
                                                        CustomCachedImageCircle(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      image: widget
                                                          .answertEntity.image,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                    kPadding.gap,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.answertEntity.isPostDone == false ||
                                widget.answertEntity.isEditDone == false
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Text(
                                    widget.answertEntity.isEditDone == false
                                        ? t.common.editing
                                        : t.common.sendingAnswer,
                                    style: context.moonTypography!.body.text10
                                        .copyWith(
                                            color: context.moonColors!.trunks
                                                .withOpacity(0.7)),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      widget.action(answerEnum.getComment);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      width: 30,
                                      child: widget.answertEntity
                                                  .amount_comments >
                                              0
                                          ? Icon(
                                              widget.answertEntity.showComment
                                                  ? MoonIcons
                                                      .generic_minus_24_light
                                                  : MoonIcons
                                                      .generic_plus_24_light,
                                              size: 25,
                                            )
                                          : SizedBox(),
                                    ),
                                  ),
                                  kPadding.gap,
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          final token =
                                              LocalStorage.getStringValue(
                                                  SharedPreferenceKeys
                                                      .accessToken);
                                          if (token.isEmpty) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const CustomAnonymousCard();
                                              },
                                            );
                                          } else {
                                            widget.action(answerEnum.like);
                                          }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Opacity(
                                                opacity: widget.opacityLike,
                                                child: Row(
                                                  children: [
                                                    widget.answertEntity.is_like
                                                        ? SvgPicture.asset(
                                                            Assets
                                                                .svg.like.path,
                                                            height: 14,
                                                            width: 14)
                                                        : SvgPicture.asset(
                                                            Assets.svg.unlike
                                                                .path,
                                                            color: context
                                                                .moonColors!
                                                                .trunks,
                                                            height: 14,
                                                            width: 14),
                                                    Gap(kPadding / 2),
                                                    Text(
                                                        "${widget.answertEntity.count_like}",
                                                        style: context
                                                            .moonTypography!
                                                            .body
                                                            .text12
                                                            .copyWith(
                                                                color: context
                                                                    .moonColors!
                                                                    .trunks))
                                                  ],
                                                ),
                                              ),
                                              kPadding2.gap,
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          widget.action(answerEnum.ontapCard);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Icon(MiconComment,
                                                  size: 18,
                                                  color: context
                                                      .moonColors!.trunks),
                                              Text(
                                                  "${widget.answertEntity.amount_comments}",
                                                  style: context.moonTypography!
                                                      .body.text12
                                                      .copyWith(
                                                          color: context
                                                              .moonColors!
                                                              .trunks)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      kPadding2.gap,
                                      kPadding.gap,
                                      MoonButton(
                                        label: Text(t.common.replie,
                                            style: context
                                                .moonTypography!.body.text12
                                                .copyWith(
                                                    color: context
                                                        .moonColors!.trunks)),
                                        onTap: () {
                                          if (token.isEmpty) {
                                            getIt
                                                .get<IAppNavigator>()
                                                .push(AppRouteInfo.login());
                                          } else {
                                            widget.reply!();
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 38,
                    ),
                    if (widget.answertEntity.showComment &&
                        widget.answertEntity.amount_comments > 0)
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                            widget.answertEntity.comments.length,
                            (index) {
                              final comment =
                                  widget.answertEntity.comments[index];
                              return CustomCommentCrad(
                                commentEntity: comment,
                                action: (value) {
                                  widget.commentAction!(
                                      CommentInAnswerAction(value, index));
                                  debugPrint("value $value");
                                },
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 48),
                            child: GestureDetector(
                              onTap: () {
                                if (token.isEmpty) {
                                  getIt
                                      .get<IAppNavigator>()
                                      .push(AppRouteInfo.login());
                                } else {
                                  widget.reply!();
                                }
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Text(
                                  "${t.common.replie}..",
                                  style: context.moonTypography!.body.text12
                                      .copyWith(
                                          color: context.moonColors!.trunks),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum moreEnum {
  edit,
  delete,
  block,
  report,
}

class CommentInAnswerAction {
  final commentEnum type;
  final int index;
  CommentInAnswerAction(this.type, this.index);
}
