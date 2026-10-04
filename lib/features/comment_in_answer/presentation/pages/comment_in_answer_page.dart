import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_comment_crad.dart';
import '../../../../core/utils/widgets/custom_empty_data.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../core/utils/widgets/custom_see_more_page.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../notification/domain/entities/user_entity.dart';
import '../../../profile/alert/block_user_alert.dart';
import '../../../profile/bottomsheet/report_buttomsheet.dart';
import '../../../profile/domain/entities/answer_entity.dart';
import '../../../question_detail/presentation/widgets/post_widget.dart';
import '../bloc/comment_in_answer_bloc.dart';

class CommentInAnswerBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required int id,
    required AnswertEntity answer,
    required int bandId,
    int notificationCommentId = -1,
  }) async {
    final padding = MediaQuery.of(context).padding;
    final fullHeight = MediaQuery.of(context).size.height -
        padding.top -
        padding.bottom -
        kPadding;

    await showModalBottomSheet(
      context: context,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // <--- THIS is the fix!
      builder: (context) {
        return _ResizableSheet(
          fullHeight: fullHeight,
          id: id,
          answer: answer,
          bandId: bandId,
          notificationCommentId: notificationCommentId,
        );
      },
    );
  }
}

class _ResizableSheet extends StatefulWidget {
  final double fullHeight;
  final int id;
  final AnswertEntity answer;
  final int bandId;
  final int notificationCommentId;

  const _ResizableSheet({
    required this.fullHeight,
    required this.id,
    required this.answer,
    required this.bandId,
    required this.notificationCommentId,
  });

  @override
  State<_ResizableSheet> createState() => _ResizableSheetState();
}

class _ResizableSheetState extends State<_ResizableSheet> {
  bool isExpanded = false;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = isExpanded ? widget.fullHeight : widget.fullHeight * 0.7;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          Navigator.of(context).pop(), // Dismiss when background tapped

      child: Align(
        // <-- This enables AnimatedContainer to resize properly
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 200),
          height: height,
          decoration: BoxDecoration(
            color: context.moonColors!.gohan,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: CommentInAnswerPage(
            id: widget.id,
            answer: widget.answer,
            bandId: widget.bandId,
            notificationcommentId: widget.notificationCommentId,
            isExpanded: isExpanded,
            onToggleExpand: toggleExpand,
          ),
        ),
      ),
    );
  }
}

@RoutePage()
class CommentInAnswerPage extends StatefulWidget {
  final int id;
  final AnswertEntity answer;
  final int bandId;
  final int notificationcommentId;
  final VoidCallback? onToggleExpand;
  final bool isExpanded;

  const CommentInAnswerPage({
    super.key,
    required this.id,
    required this.bandId,
    required this.answer,
    required this.notificationcommentId,
    this.onToggleExpand,
    this.isExpanded = true,
  });

  @override
  State<CommentInAnswerPage> createState() => _CommentInAnswerPageState();
}

class _CommentInAnswerPageState
    extends BasePageBlocState<CommentInAnswerPage, CommentInAnswerBloc> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    bloc.add(GetCommentEvent(widget.id));
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<CommentInAnswerBloc, CommentInAnswerState>(
        builder: (context, state) {
          return SafeArea(
            top: false,
            child: Column(
              children: [
                kPadding.gap,
                SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          widget.answer.name,
                          style: context.moonTypography!.heading.text16,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(right: kPadding),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MoonButton.icon(
                                buttonSize: MoonButtonSize.sm,
                                borderRadius: BorderRadius.circular(50),
                                icon: Icon(
                                  widget.isExpanded
                                      ? MoonIcons.controls_collapse_24_regular
                                      : MoonIcons.controls_expand_24_regular,
                                  size: 20,
                                ),
                                onTap: widget.onToggleExpand ?? () {},
                              ),
                              const Gap(8),
                              MoonButton.icon(
                                buttonSize: MoonButtonSize.sm,
                                borderRadius: BorderRadius.circular(50),
                                icon: const Icon(
                                  MoonIcons.controls_close_24_regular,
                                  size: 20,
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     kPadding.gap,
                //     if (widget.answer.image.isNotEmpty)
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (_) => DisplayImagePage(
                //                 tag: "commentInAnswer",
                //                 imageUrl: widget.answer.image,
                //                 report:
                //                     ReportInput(answer_id: widget.answer.id),
                //                 isYourImage: widget.answer.is_your,
                //               ),
                //             ),
                //           );
                //         },
                //         child: Hero(
                //           tag: "commentInAnswer",
                //           child: CustomAvatar(
                //             image: widget.answer.image,
                //             high: 50,
                //             width: 50,
                //           ),
                //         ),
                //       ),
                //     // const Gap(kPadding),
                //     // Expanded(
                //     //   child: Text(
                //     //     widget.answer.description,
                //     //     style: context.moonTypography!.body.text14.copyWith(
                //     //       color: context.moonColors!.trunks,
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),
                const AppDivider.medium(),
                Expanded(
                  child: state.isloading && state.comments.isEmpty
                      ? const Center(child: CustomLoading())
                      : state.comments.isEmpty
                          ? const Center(child: CustomEmptyData())
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
                              child: AppSmartRefreshScrollView(
                                // isRefresh: false,
                                enableLoadMore:
                                    state.isMorePage && state.page != 2,
                                onLoadMore: () async {
                                  bloc.add(GetCommentEvent(widget.id));
                                },
                                onRefresh: () async =>
                                    bloc.add(RefresPage(widget.id)),
                                child: ListView.separated(
                                  itemCount: state.comments.length,
                                  separatorBuilder: (_, __) => const Gap(0),
                                  itemBuilder: (context, index) {
                                    final comment = state.comments[index];
                                    return Column(
                                      children: [
                                        CustomCommentCrad(
                                          commentId:
                                              widget.notificationcommentId,
                                          commentEntity: comment,
                                          action: (value) async {
                                            switch (value) {
                                              case commentEnum.edit:
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 50));
                                                FocusScope.of(context)
                                                    .requestFocus(focusNode);
                                                bloc.add(ClickEditEvent(index));
                                                break;
                                              case commentEnum.delete:
                                                bloc.add(
                                                    ClickDeleteEvent(index));
                                                break;
                                              case commentEnum.report:
                                                ReportButtomsheet.show(
                                                  context: context,
                                                  commentId: comment.id,
                                                );
                                                break;
                                              case commentEnum.block:
                                                BlockUserAlert.show(
                                                  context: context,
                                                  user: UserEntity(
                                                    id: comment.user_id,
                                                    name: comment.name,
                                                  ),
                                                );
                                                break;
                                              case commentEnum.tapProfile:
                                                appRoute.push(
                                                    AppRouteInfo.otherProfile(
                                                  userId: comment.user_id,
                                                ));
                                                break;
                                              case commentEnum.like:
                                                bloc.add(ClickLike(index));
                                                break;
                                            }
                                          },
                                        ),
                                        if (state.page == 2 &&
                                            state.isMorePage &&
                                            index + 1 == state.comments.length)
                                          CustomSeeMorePage(
                                            title: t.comment.seemore,
                                            ontap: () => bloc.add(
                                              GetCommentEvent(widget.id),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                ),
                PostWidget(
                  hintText: t.comment.hitText,
                  focusNode: focusNode,
                  action: (value) {
                    switch (value) {
                      case postWidgetEnum.cancel:
                        bloc.add(ClickCancelEditEvent());
                        break;
                      case postWidgetEnum.edit:
                        bloc.add(ClickUpdateEvent());
                        break;
                      case postWidgetEnum.pickImage:
                      case postWidgetEnum.clearImage:
                        break;
                      case postWidgetEnum.postMessage:
                        bloc.add(ClickCreateEventCommentEvent(
                          widget.id,
                          widget.bandId,
                        ));
                        break;
                    }
                  },
                  enablePost: state.enableComment,
                  oldMessage: state.oldMessage,
                  message: state.message,
                  messageController: state.desTextController,
                  onChanged: (value) => bloc.add(DesChangedEvent(value)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
