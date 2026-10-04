import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_answer_card.dart';
import '../../../../core/utils/widgets/custom_comment_crad.dart';
import '../../../notification/domain/entities/user_entity.dart';
import '../../../profile/bottomsheet/report_buttomsheet.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../profile/alert/block_user_alert.dart';
import '../../../question_detail/presentation/widgets/post_widget.dart';
import '../bloc/bloc.dart';
import '../widget/answer_simmer_widget.dart';

@RoutePage()
class AnswerPage extends StatefulWidget {
  final int id;
  final int bandId;
  final bool yourQuestion;
  final int answerId;
  final bool isScrollingDown;
  const AnswerPage(
      {super.key,
      required this.id,
      this.bandId = 0,
      this.isScrollingDown = true,
      this.yourQuestion = false,
      this.answerId = -1});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends BasePageBlocState<AnswerPage, AnswerBloc>
    with SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    bloc.add(GetAnswerEvent(widget.id));
    super.initState();
  }

  FocusNode myFocusNode = FocusNode();
  @override
  Widget buildPage(BuildContext context) {
    bloc.add(ScrollDirectionUpdate(widget.isScrollingDown));
    return BlocBuilder<AnswerBloc, AnswerState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            unFocus();
          },
          child: SizedBox(
            // height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: state.isloading && state.answer.isEmpty
                      ? const Center(
                          child: AnswerSimmerWidget(),
                        )
                      : state.answer.isEmpty
                          ? const Center(child: SizedBox())
                          : AppSmartRefreshScrollView(
                              enableLoadMore: state.isMorePage,
                              onLoadMore: () async =>
                                  bloc.add(GetAnswerEvent(widget.id)),
                              onRefresh: () async {
                                bloc.add(RefreshPage(widget.id));
                              },
                              child: ListView.separated(
                                  // reverse:
                                  //     true, // Pushes the focused TextField into view

                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final answer = state.answer[index];
                                    return CustomAnswerCrad(
                                      reply: () {
                                        bloc.add(ClickReplyComment(index, 0));
                                        myFocusNode.requestFocus();
                                      },
                                      answerId: widget.answerId,
                                      isYourQuestion: widget.yourQuestion,
                                      answertEntity: answer,
                                      commentAction: (action) async {
                                        switch (action.type) {
                                          case commentEnum.edit:
                                            await Future.delayed(const Duration(
                                                milliseconds: 500));
                                            FocusScope.of(context)
                                                .requestFocus(myFocusNode);
                                            bloc.add(ClickEditComment(
                                                index, action.index));
                                            break;
                                          case commentEnum.delete:
                                            bloc.add(ClickDeleteComment(
                                                index, action.index));
                                            break;
                                          case commentEnum.report:
                                            await Future.delayed(const Duration(
                                                milliseconds: 500));
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
                                          // appRoute.push(
                                          //     AppRouteInfo.otherProfile(
                                          //         userId:
                                          //             comment.user_id));
                                          // break;
                                          case commentEnum.like:
                                            bloc.add(ClickLlikeComment(
                                                index, action.index));
                                            break;
                                        }
                                      },
                                      action: (value) async {
                                        switch (value) {
                                          case answerEnum.profile:
                                            bloc.add(ClickProfileEvent(
                                                answer.user_id));
                                            break;
                                          case answerEnum.like:
                                            bloc.add(ClickLikeEvent(index));
                                            break;
                                          case answerEnum.ontapCard:
                                            appRoute.push(
                                                AppRouteInfo.commentInAnswer(
                                                    answer.id,
                                                    answer,
                                                    -1,
                                                    widget.bandId));
                                            break;
                                          case answerEnum.correct:
                                            bloc.add(ClickCorrentEvent(
                                                context, index));
                                            break;
                                          case answerEnum.edit:
                                            appRoute.pop();
                                            await Future.delayed(const Duration(
                                                milliseconds: 250));
                                            myFocusNode.requestFocus();
                                            bloc.add(ClickEditEvent(index));
                                            break;
                                          case answerEnum.delete:
                                            bloc.add(ClickDeleteEvent(
                                                context, index));
                                            break;
                                          case answerEnum.report:
                                            appRoute.pop();
                                            await Future.delayed(const Duration(
                                                milliseconds: 250));
                                            await ReportButtomsheet.show(
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
                                            bloc.add(ClickDownloadImage(
                                                answer.image));
                                            break;
                                          case answerEnum.getComment:
                                            bloc.add(ClickGetComment(index));
                                            break;
                                        }
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Gap(0),
                                  itemCount: state.answer.length),
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
                                  bloc.add(ClickCancelEditEvent());
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
                              bloc.add(CommentMesChanged(value));
                            },
                          )
                        : PostWidget(
                            hintText: t.common.answer,
                            postImage: true,
                            enablePost: state.enableAnswer,
                            image: state.urlImage,
                            file: state.image,
                            action: (value) async {
                              switch (value) {
                                case postWidgetEnum.cancel:
                                  bloc.add(ClickCancelEditEvent());
                                  break;
                                case postWidgetEnum.edit:
                                  bloc.add(ClickUpdateEvent());
                                  break;
                                case postWidgetEnum.pickImage:
                                  try {
                                    unFocus();
                                    final image = await pickImage();
                                    bloc.add(ClickPickImageEvent(image));
                                    myFocusNode.requestFocus();
                                  } catch (v) {
                                    debugPrint("dfdf");
                                    myFocusNode.requestFocus();
                                  }
                                  break;
                                case postWidgetEnum.clearImage:
                                  bloc.add(ClickClearImageEvent());
                                  break;
                                case postWidgetEnum.postMessage:
                                  bloc.add(ClcikCreateAnswerEvent(
                                      widget.id, widget.bandId));
                                  break;
                              }
                            },
                            message: state.message,
                            messageController: state.messageController,
                            oldMessage: state.oldMessage,
                            focusNode: myFocusNode,
                            onChanged: (value) {
                              bloc.add(DescriptionChangedEvent(value));
                            },
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
