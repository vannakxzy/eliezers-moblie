import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_comment_crad.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../notification/domain/entities/user_entity.dart';
import '../../../profile/alert/block_user_alert.dart';
import '../../../profile/bottomsheet/report_buttomsheet.dart';
import '../../../question_detail/presentation/widgets/post_widget.dart';
import '../bloc/comment_in_question_bloc.dart';

class CommentInQuestionBottomSheet {
  static Future<int> show({
    required BuildContext context,
    required int id,
    int bandId = 0,
    int commentId = -1,
  }) async {
    final padding = MediaQuery.of(context).padding;
    final fullHeight = MediaQuery.of(context).size.height -
        padding.top -
        padding.bottom -
        kPadding;

    final result = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _ResizableSheet(
          fullHeight: fullHeight,
          id: id,
          bandId: bandId,
          commentId: commentId,
        );
      },
    );

    return result ?? 0; // Ensure a valid int is returned
  }
}

class _ResizableSheet extends StatefulWidget {
  final double fullHeight;
  final int id;
  final int bandId;
  final int commentId;

  const _ResizableSheet({
    required this.fullHeight,
    required this.id,
    required this.bandId,
    required this.commentId,
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

    return AnimatedContainer(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 200),
      height: height,
      decoration: BoxDecoration(
        color: context.moonColors!.gohan,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: CommentInQuestionPage(
        id: widget.id,
        bandId: widget.bandId,
        commentId: widget.commentId,
        onToggleExpand: toggleExpand,
        isExpanded: isExpanded,
      ),
    );
  }
}

@RoutePage()
class CommentInQuestionPage extends StatefulWidget {
  final int id;
  final int bandId;
  final int commentId;
  final VoidCallback? onToggleExpand;
  final bool isExpanded;

  const CommentInQuestionPage({
    super.key,
    required this.id,
    this.bandId = 0,
    this.commentId = -1,
    this.onToggleExpand,
    this.isExpanded = true,
  });

  @override
  State<CommentInQuestionPage> createState() => _CommentInQuestionPageState();
}

class _CommentInQuestionPageState
    extends BasePageBlocState<CommentInQuestionPage, CommentInQuestionBloc> {
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    bloc.add(GetCommentEvent(widget.id));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<CommentInQuestionBloc, CommentInQuestionState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  // padding: const EdgeInsets.only(right: kPadding2),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(t.common.question,
                            style: context.moonTypography!.heading.text16),
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MoonButton.icon(
                              buttonSize: MoonButtonSize.sm,
                              icon: Icon(
                                widget.isExpanded
                                    ? MoonIcons.controls_collapse_24_regular
                                    : MoonIcons.controls_expand_24_regular,
                                size: 20,
                              ),
                              onTap: widget.onToggleExpand ?? () {},
                            ),
                            MoonButton.icon(
                              buttonSize: MoonButtonSize.sm,
                              icon: const Icon(
                                MoonIcons.controls_close_24_regular,
                                size: 20,
                              ),
                              onTap: () =>
                                  Navigator.of(context).pop(state.valueUpdated),
                            ),
                            kPadding2.gap,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AppDivider.medium(),
                Expanded(
                  child: state.getLoadingComment && state.comments.isEmpty
                      ? const Center(child: CustomLoading())
                      : state.comments.isEmpty
                          ? Center(
                              child: Text(
                                t.comment.noData,
                                style: context.moonTypography!.body.text12
                                    .copyWith(
                                        color: context.moonColors!.trunks),
                              ),
                            )
                          : ListView.builder(
                              itemCount: state.comments.length,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding2),
                              itemBuilder: (context, index) {
                                final comment = state.comments[index];
                                return CustomCommentCrad(
                                  commentId: widget.commentId,
                                  commentEntity: comment,
                                  action: (value) async {
                                    switch (value) {
                                      case commentEnum.edit:
                                        await Future.delayed(
                                            const Duration(milliseconds: 500));
                                        FocusScope.of(context)
                                            .requestFocus(myFocusNode);
                                        bloc.add(ClickEditEvent(index));
                                        break;
                                      case commentEnum.delete:
                                        bloc.add(ClickDeleteEvent(index));
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
                                          ),
                                        );
                                        break;
                                      case commentEnum.like:
                                        bloc.add(ClickLike(index));
                                        break;
                                    }
                                  },
                                );
                              },
                            ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: kPadding),
                  child: PostWidget(
                    hintText: t.comment.hitText,
                    action: (value) {
                      switch (value) {
                        case postWidgetEnum.cancel:
                          bloc.add(ClickCancelEditEvent());
                          break;
                        case postWidgetEnum.edit:
                          bloc.add(ClickUpdateEvent());
                          break;
                        case postWidgetEnum.postMessage:
                          bloc.add(ClickCreateEventcommentEvent(
                              widget.id, widget.bandId));
                          break;
                        case postWidgetEnum.pickImage:
                        case postWidgetEnum.clearImage:
                          break;
                      }
                    },
                    enablePost: state.enableComment,
                    focusNode: myFocusNode,
                    message: state.message,
                    oldMessage: state.oldMessage,
                    messageController: state.desTextController,
                    onChanged: (value) {
                      bloc.add(DesChangedEvent(value));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
