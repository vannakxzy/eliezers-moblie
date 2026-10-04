import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../../app/base/navigation/app_navigator.dart';
import '../../../config/router/page_route/app_route_info.dart';
import '../../../di/di.dart';
import '../../../gen/assets.gen.dart';
import '../../constants/constants.dart';
import '../../helper/local_data/storge_local.dart';
import 'custom_avata.dart';
import '../../../features/question_detail/domain/entities/comment_entity.dart';
import '../../../features/setting/bottomsheet/comment_buttomsheet.dart';

import '../../../gen/i18n/translations.g.dart';

class CustomCommentCrad extends StatefulWidget {
  final CommentEntity commentEntity;
  final ValueChanged<commentEnum> action;
  final int commentId;
  const CustomCommentCrad({
    super.key,
    this.commentId = -1,
    required this.commentEntity,
    required this.action,
  });

  @override
  State<CustomCommentCrad> createState() => _CustomCommentCradState();
}

class _CustomCommentCradState extends State<CustomCommentCrad> {
  late bool isAnimated;

  @override
  void initState() {
    super.initState();
    isAnimated = widget.commentEntity.id == widget.commentId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isAnimated = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);

    return GestureDetector(
      onLongPress: () {
        if (widget.commentEntity.isPostDone == true &&
            widget.commentEntity.isEditDone == true) {
          CommentButtomsheet.showBottomSheet(
              context, widget.commentEntity.is_your, (value) {
            if (widget.commentEntity.isPostDone) {
              Navigator.pop(context);
              widget.action(value);
            }
          });
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
              child: AnimatedOpacity(
            curve: Curves.easeIn,
            opacity: isAnimated ? 1 : 0,
            duration: const Duration(seconds: 2),
            child: Container(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(kRadius2)),
            ),
          )),
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(left: kPadding, right: kPadding),
            padding: const EdgeInsets.only(bottom: kPadding, top: kPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.action(commentEnum.tapProfile);
                  },
                  child: CustomAvatar(
                    image: widget.commentEntity.avatar,
                    high: 30,
                    width: 30,
                  ),
                ),
                kPadding.gap,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "${widget.commentEntity.name} . ",
                            style: context.moonTypography!.heading.text12),
                        TextSpan(
                          text: "${widget.commentEntity.date} . ",
                          style: context.moonTypography!.body.text12
                              .copyWith(color: context.moonColors!.trunks),
                        )
                      ])),
                      Text(
                        widget.commentEntity.message,
                        style: context.moonTypography!.body.text12,
                      ),
                      if (!widget.commentEntity.isPostDone ||
                          !widget.commentEntity.isEditDone)
                        Text(
                          widget.commentEntity.isPostDone == false ||
                                  widget.commentEntity.isEditDone == false
                              ? widget.commentEntity.isPostDone == false
                                  ? t.common.sendingComment
                                  : t.common.editing
                              : "",
                          style: context.moonTypography!.body.text10.copyWith(
                              color:
                                  context.moonColors!.trunks.withOpacity(0.7)),
                        ),
                      GestureDetector(
                        onTap: () {
                          if (token.isEmpty) {
                            getIt
                                .get<IAppNavigator>()
                                .push(AppRouteInfo.login());
                          } else {
                            widget.action(commentEnum.like);
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.only(top: kPadding),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                widget.commentEntity.is_like
                                    ? SvgPicture.asset(Assets.svg.like.path,
                                        height: 13, width: 13)
                                    : SvgPicture.asset(Assets.svg.unlike.path,
                                        color: context.moonColors!.trunks
                                            .withOpacity(0.7),
                                        height: 13,
                                        width: 13),
                                Gap(kPadding / 2),
                                Text("${widget.commentEntity.count_like}",
                                    style: context.moonTypography!.body.text10
                                        .copyWith(
                                      color: context.moonColors!.trunks
                                          .withOpacity(0.7),
                                    ))
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum commentEnum { edit, delete, report, block, tapProfile, like }
