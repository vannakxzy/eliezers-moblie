import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/icon_constant.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../core/utils/widgets/custom_anonymous_card.dart';
import '../../../../core/utils/widgets/custom_answer_card.dart';
import '../../../../core/utils/widgets/custom_answer_discussion.dart';
import '../../../../core/utils/widgets/custom_comment_crad.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../home/domain/entities/question_entity.dart';
import '../../../notification/domain/entities/user_entity.dart';
import '../../../profile/alert/block_user_alert.dart';
import '../../../profile/bottomsheet/report_buttomsheet.dart';
import '../../../question_detail/presentation/widgets/post_widget.dart';
import '../../../setting/bottomsheet/question_detail_buttomsheet.dart';
import '../../alert/confirm_delete_discussion_alert.dart';
import '../bloc/bloc/discussion_detail_bloc.dart';
import '../widgets/discussion_cover_widget.dart';
import 'comment_in_discussion_page.dart';

@RoutePage()
class DiscussionDetailPage extends StatefulWidget {
  final QuestionEntity? discussion;
  final int? answerId;
  final int discussionId;

  const DiscussionDetailPage({
    super.key,
    this.discussion,
    this.answerId,
    this.discussionId = 0,
  });

  @override
  State<DiscussionDetailPage> createState() => _DiscussionDetailPageState();
}

class _DiscussionDetailPageState
    extends BasePageBlocState<DiscussionDetailPage, DiscussionDetailBloc> {
  FocusNode myFocusNode = FocusNode();
  final _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() {
      bloc.add(ListionScroll(_scrollController.offset));
    });
    bloc.add(InitPage(widget.discussion!, widget.discussionId));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<DiscussionDetailBloc, DiscussionDetailState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            top: false,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: NotificationListener<ScrollUpdateNotification>(
                        onNotification:
                            (ScrollUpdateNotification notification) {
                          if (_scrollController.position.userScrollDirection ==
                              ScrollDirection.reverse) {
                            bloc.add(ScrollDirectionUpdate(false));
                          } else if (_scrollController
                                  .position.userScrollDirection ==
                              ScrollDirection.forward) {
                            bloc.add(ScrollDirectionUpdate(true));
                          }
                          return true;
                        },
                        child: AppSmartRefreshScrollView(
                            enableLoadMore: state.isMorePage,
                            onLoadMore: () async {
                              bloc.add(GetAnswerInDiscussionEvent(
                                  widget.discussion!.id));
                            },
                            onRefresh: () async {
                              bloc.add(RefresPageEvent());
                            },
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: state.answer.isEmpty
                                  ? 1
                                  : state.answer.length + 1,
                              itemBuilder: (context, Rindex) {
                                if (Rindex == 0) {
                                  return DiscussionCoverWidget(
                                      ontapProfile: () {
                                        bloc.add(ClickProfileEvent(
                                            state.discussion.userId));
                                      },
                                      ontapLike: () {
                                        debugPrint("dsfsdfsfd");
                                        bloc.add(ClickLikeDiscussion(0));
                                      },
                                      discussion: state.discussion);
                                }
                                int index = Rindex - 1;
                                final answer = state.answer[index];
                                return CustomAnswerDiscussion(
                                  isCommnity: true,
                                  reply: () {
                                    debugPrint("value a");
                                    bloc.add(ClickReplyComment(index, 0));
                                    myFocusNode.requestFocus();
                                  },
                                  answerId: widget.answerId ?? 0,
                                  isYourQuestion:
                                      widget.discussion!.isYourQuestion,
                                  answertEntity: answer,
                                  commentAction: (action) async {
                                    switch (action.type) {
                                      case commentEnum.edit:
                                        bloc.add(ClickEditComment(
                                            index, action.index));
                                        await Future.delayed(
                                            const Duration(milliseconds: 500));
                                        FocusScope.of(context)
                                            .requestFocus(myFocusNode);
                                        break;
                                      case commentEnum.delete:
                                        bloc.add(ClickDeleteComment(
                                            index, action.index));
                                        break;
                                      case commentEnum.report:
                                        ReportButtomsheet.show(
                                            context: context,
                                            commentId: answer
                                                .comments[action.index].id);
                                        break;
                                      case commentEnum.block:
                                      // BlockUserAlert.show(
                                      //   context: context,
                                      //   user: UserEntity(
                                      //       id: comment.user_id,
                                      //       name: comment.name),
                                      // );
                                      // break;
                                      case commentEnum.tapProfile:
                                        appRoute.push(AppRouteInfo.otherProfile(
                                            userId: answer
                                                .comments[action.index]
                                                .user_id));
                                        break;
                                      case commentEnum.like:
                                        bloc.add(ClickLlikeComment(
                                            index, action.index));
                                        break;
                                    }
                                  },
                                  action: (value) async {
                                    switch (value) {
                                      case answerEnum.profile:
                                        bloc.add(
                                            ClickProfileEvent(answer.user_id));
                                        break;
                                      case answerEnum.like:
                                        bloc.add(ClickLikeAnswerEvent(index));
                                        break;
                                      case answerEnum.ontapCard:
                                        await CommentInDiscussionBottomSheet
                                            .show(
                                                context: context,
                                                id: answer.id,
                                                bandId: state.discussion.bandId,
                                                answer: answer);
                                        break;
                                      case answerEnum.correct:
                                        break;
                                      case answerEnum.edit:
                                        appRoute.pop();
                                        await Future.delayed(
                                            const Duration(milliseconds: 250));
                                        myFocusNode.requestFocus();
                                        bloc.add(ClickEditAnswer(index));
                                        break;
                                      case answerEnum.delete:
                                        bloc.add(ClickDeleteAnswer(index));
                                        break;
                                      case answerEnum.report:
                                        ReportButtomsheet.show(
                                            context: context,
                                            answerId: answer.id);
                                        break;
                                      case answerEnum.block:
                                        await BlockUserAlert.show(
                                            context: context,
                                            user: UserEntity(
                                                id: answer.user_id,
                                                name: answer.name));
                                        break;
                                      case answerEnum.downloadImage:
                                        bloc.add(ClickDownloadImage());
                                        break;
                                      case answerEnum.getComment:
                                        bloc.add(ClickGetComment(index));
                                        break;
                                    }
                                  },
                                );
                              },
                            )),
                      ),
                    ),
                    if (state.isScrollingDown)
                      SafeArea(
                        top: false,
                        child: state.isComment
                            ? PostWidget(
                                cencalReply: () {
                                  bloc.add(ClickCancelReply());
                                },
                                isReply: state.oldMessage.isEmpty,
                                replyTo: state.replyTo,
                                hintText: t.common.comment,
                                enablePost: state.message.isNotEmpty,
                                action: (value) async {
                                  switch (value) {
                                    case postWidgetEnum.cancel:
                                      bloc.add(ClickCancelEdit());
                                      break;
                                    case postWidgetEnum.edit:
                                      bloc.add(ClickUpdateComment());
                                      break;
                                    case postWidgetEnum.pickImage:
                                      break;
                                    case postWidgetEnum.clearImage:
                                      break;
                                    case postWidgetEnum.postMessage:
                                      bloc.add(CreateComment());
                                      break;
                                  }
                                },
                                message: state.message,
                                messageController: state.messageController,
                                oldMessage: state.oldMessage,
                                focusNode: myFocusNode,
                                onChanged: (value) {
                                  bloc.add(MessageChangedEvent(value));
                                },
                              )
                            : PostWidget(
                                hintText: t.common.replie,
                                postImage: true,
                                enablePost: state.enableAnswer,
                                image: state.urlImage,
                                file: state.file,
                                action: (value) async {
                                  switch (value) {
                                    case postWidgetEnum.cancel:
                                      bloc.add(ClickCancelEdit());
                                      break;
                                    case postWidgetEnum.edit:
                                      bloc.add(ClickUpdateAnswer());
                                      break;
                                    case postWidgetEnum.pickImage:
                                      try {
                                        unFocus();
                                        final image = await pickImage();
                                        bloc.add(ClickPickImageEvent(image));
                                        myFocusNode.requestFocus();
                                      } catch (v) {
                                        myFocusNode.requestFocus();
                                      }
                                      break;
                                    case postWidgetEnum.clearImage:
                                      bloc.add(ClickClearImageEvent());
                                      break;
                                    case postWidgetEnum.postMessage:
                                      bloc.add(ClcikPostDiscussion(
                                          widget.discussion!.id,
                                          state.discussion.bandId));
                                      break;
                                  }
                                },
                                message: state.message,
                                messageController: state.messageController,
                                oldMessage: state.oldMessage,
                                focusNode: myFocusNode,
                                onChanged: (value) {
                                  bloc.add(MessageChangedEvent(value));
                                },
                              ),
                      )
                  ],
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  padding: EdgeInsets.only(
                      left: kPadding,
                      right: kPadding,
                      bottom: kPadding,
                      top: MediaQuery.of(context).padding.top),
                  color: state.showBackground
                      ? context.moonColors!.frieza
                      : Colors.transparent,
                  height: MediaQuery.of(context).padding.top + 40,
                  child: Row(
                    children: [
                      MoonButton.icon(
                        onTap: () {
                          Navigator.of(context).pop(state.discussion);
                        },
                        buttonSize: MoonButtonSize.sm,
                        borderRadius: BorderRadius.circular(100),
                        backgroundColor:
                            context.moonColors!.heles.withOpacity(0.7),
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Spacer(),
                      MoonButton.icon(
                        buttonSize: MoonButtonSize.sm,
                        borderRadius: BorderRadius.circular(100),
                        backgroundColor:
                            context.moonColors!.heles.withOpacity(0.7),
                        onTap: () {
                          bloc.add(ClickShare(state.discussion));
                        },
                        icon: Icon(
                          MiconSend,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      kPadding.gap,
                      MoonButton.icon(
                        buttonSize: MoonButtonSize.sm,
                        borderRadius: BorderRadius.circular(100),
                        backgroundColor:
                            context.moonColors!.heles.withOpacity(0.7),
                        onTap: () async {
                          try {
                            await QuestionDetailButtonsheet.showBottomSheet(
                              context,
                              state.discussion.isYourQuestion,
                              state.discussion.image,
                              (value) async {
                                Navigator.pop(context);
                                final token = LocalStorage.getStringValue(
                                    SharedPreferenceKeys.accessToken);
                                if (token.isEmpty &&
                                    (value != questionMoreEnum.share &&
                                        value !=
                                            questionMoreEnum.downloadImage)) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const CustomAnonymousCard();
                                    },
                                  );
                                } else {
                                  switch (value) {
                                    case questionMoreEnum.downloadImage:
                                      bloc.add(ClickDownloadPhoroEvent(
                                          state.discussion.image));
                                      break;
                                    case questionMoreEnum.edit:
                                      await Future.delayed(
                                          const Duration(milliseconds: 200));
                                      QuestionEntity discussion = await appRoute
                                              .push(AppRouteInfo.editDiscussion(
                                                  state.discussion))
                                          as QuestionEntity;
                                      bloc.add(ClickUpdateQuestion(discussion));
                                      break;
                                    case questionMoreEnum.delete:
                                      bool done =
                                          await ConfirmDeleteDiscussionAlert
                                              .show(context: context);
                                      if (done) {
                                        Navigator.pop(context);
                                        bloc.add(ClickDeleteDiscusstionEvent(
                                            state.discussion.id));
                                      }
                                      break;
                                    case questionMoreEnum.hide:
                                      await Future.delayed(
                                          Duration(milliseconds: 500));
                                      Navigator.of(context).pop(state.discussion
                                          .copyWith(isHide: true));
                                      break;
                                    case questionMoreEnum.report:
                                      await Future.delayed(
                                          const Duration(milliseconds: 200));
                                      ReportButtomsheet.show(
                                          context: context,
                                          questionId: state.discussion.id);
                                      break;
                                    case questionMoreEnum.block:
                                      await BlockUserAlert.show(
                                          context: context,
                                          user: UserEntity(
                                              id: state.discussion.userId,
                                              name: state.discussion.name));
                                      break;
                                    case questionMoreEnum.share:
                                      bloc.add(ClickShare(state.discussion));
                                      break;
                                  }
                                }
                              },
                            );
                          } catch (value) {
                            debugPrint("value $value");
                          }
                        },
                        icon: Icon(
                          MoonIcons.other_3_dots_horizontal_32_regular,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
