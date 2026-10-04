import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../core/utils/widgets/custom_question_card.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../../../category/save_question/save_question_page.dart';
import '../../../discussions/showbuttomsheet/filter_widget_buttomsheet.dart';
import '../../../profile/bottomsheet/report_buttomsheet.dart';
import '../../../setting/bottomsheet/profile_buttonsheet.dart';
import '../../alert/more_band_alert.dart';
import '../../domain/entities/band_entity.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../bloc/bloc/band_detail_bloc.dart';
import '../widgets/band_detail_empty_widget.dart';
import '../widgets/cover_band_widget.dart';
import '../widgets/status_band_widget.dart';

@RoutePage()
class bandDetailPage extends StatefulWidget {
  final int bandId;
  final BandEntity band;
  const bandDetailPage({super.key, required this.bandId, required this.band});

  @override
  State<bandDetailPage> createState() => _bandDetailPageState();
}

class _bandDetailPageState
    extends BasePageBlocState<bandDetailPage, bandDetailBloc> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      bloc.add(ListionScroll(_scrollController.offset));
    });
    bloc.add(InitCommunitDetail(widget.band, widget.bandId));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    double highCover = MediaQuery.sizeOf(context).height / 4 + 50;
    final token = LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);
    return Scaffold(
      body: BlocBuilder<bandDetailBloc, bandDetailState>(
        builder: (context, state) {
          return SafeArea(
            top: false,
            child: state.band == BandEntity()
                ? Center(
                    child: MoonCircularLoader(),
                  )
                : Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: context.moonColors!.goku,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: state.loaingQuestion &&
                                            state.questions.isEmpty
                                        ? Center(
                                            child: CustomLoading(),
                                          )
                                        : AppSmartRefreshScrollView(
                                            enableLoadMore: state.isMorePage,
                                            onLoadMore: () async {
                                              bloc.add(InitCommunitDetail(
                                                  widget.band, widget.bandId));
                                            },
                                            onRefresh: () async {
                                              bloc.add(RefreshPage());
                                            },
                                            child: ListView.separated(
                                              controller: _scrollController,
                                              itemCount:
                                                  state.questions.length + 1,
                                              separatorBuilder: (_, index) =>
                                                  AppDivider.medium(),
                                              itemBuilder: (_, Rindex) {
                                                if (Rindex == 0)
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Coverbandwidget(
                                                        band: state.band,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(kPadding),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              state.band.name,
                                                              style: context
                                                                  .moonTypography!
                                                                  .heading
                                                                  .text20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              2),
                                                                  child: Icon(
                                                                    MoonIcons
                                                                        .maps_world_16_light,
                                                                    color: context
                                                                        .moonColors!
                                                                        .trunks,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                                Gap(4),
                                                                Text(
                                                                    state.band
                                                                            .isPublic
                                                                        ? t.band
                                                                            .privateAudienceTitle
                                                                        : t.band
                                                                            .publicAudienceTitle,
                                                                    style: context
                                                                        .moonTypography!
                                                                        .body
                                                                        .text14
                                                                        .copyWith(
                                                                            color:
                                                                                context.moonColors!.trunks)),
                                                                kPadding.gap,
                                                                RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                "${state.band.member} ",
                                                                            style:
                                                                                context.moonTypography!.heading.text16.copyWith(color: context.moonColors!.bulma)),
                                                                        TextSpan(
                                                                            text:
                                                                                " ${t.common.member}    .    ${state.band.question}  ${t.common.question} , ${state.band.discussion}  ${t.common.discussion}",
                                                                            style:
                                                                                context.moonTypography!.body.text14.copyWith(color: context.moonColors!.trunks))
                                                                      ]),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      state.questions.isEmpty
                                                          ? bandDetailEmptyWidget()
                                                          : InkWell(
                                                              onTap: () async {
                                                                final filer =
                                                                    await FilterWidget.show(
                                                                        context,
                                                                        state
                                                                            .filter);
                                                                if (filer !=
                                                                    null) {
                                                                  bloc.add(
                                                                      ApplyFilerEvent(
                                                                          filer));
                                                                }
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            kPadding),
                                                                color: context
                                                                    .moonColors!
                                                                    .beerus
                                                                    .withOpacity(
                                                                        0.2),
                                                                height: 30,
                                                                width: double
                                                                    .infinity,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      t.filter
                                                                          .title,
                                                                      style: context
                                                                          .moonTypography!
                                                                          .heading
                                                                          .text16
                                                                          .copyWith(
                                                                              color: context.moonColors!.trunks),
                                                                    ),
                                                                    MoonButton
                                                                        .icon(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      icon:
                                                                          Icon(
                                                                        MoonIcons
                                                                            .media_tuner_24_regular,
                                                                        color: context
                                                                            .moonColors!
                                                                            .trunks,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                    ],
                                                  );
                                                int index = Rindex - 1;
                                                final questions =
                                                    state.questions[index];
                                                return CustomQuestionCard(
                                                    questionEntity: questions,
                                                    onPressed: () {
                                                      bloc.add(
                                                          ClickQuestionEvetn(
                                                              questions,
                                                              questions.id));
                                                    },
                                                    onDoubleTap: () {
                                                      bloc.add(DoubleTapEvent(
                                                          index));
                                                    },
                                                    onTapLike: () {
                                                      bloc.add(ClickLikeEvent(
                                                          index));
                                                    },
                                                    onTapUnHide: () {
                                                      bloc.add(ClickUnHideEvent(
                                                          index));
                                                    },
                                                    longPressEnd:
                                                        (value) async {
                                                      if (value ==
                                                          actionEnum.report) {
                                                        ReportButtomsheet.show(
                                                            context: context,
                                                            commentId:
                                                                questions.id);
                                                      }
                                                      if (value ==
                                                          actionEnum.share) {
                                                        bloc.add(
                                                            ClickShareQuestion(
                                                                questions));
                                                      }
                                                      if (value ==
                                                          actionEnum.like) {
                                                        bloc.add(ClickLikeEvent(
                                                            index));
                                                      }
                                                      if (value ==
                                                          actionEnum.hide) {
                                                        bloc.add(ClickHideEvent(
                                                            index));
                                                      }
                                                      if (value ==
                                                          actionEnum.save) {
                                                        if (questions
                                                            .is_saved) {
                                                          bloc.add(
                                                              ClickSaveQuestion(
                                                                  index));
                                                        } else {
                                                          bool save =
                                                              await SaveQuestionToCategoryBottomSheet.show(
                                                                  context:
                                                                      context,
                                                                  questionId:
                                                                      questions
                                                                          .id) as bool;
                                                          if (save) {
                                                            bloc.add(
                                                                ClickSaveQuestion(
                                                                    index));
                                                          }
                                                        }
                                                      }
                                                    });
                                              },
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(bottom: kPadding),
                            child: StatusbandWidget(
                              band: state.band,
                              ontap: () {
                                if (token.isEmpty) {
                                  appRoute.push(AppRouteInfo.login());
                                } else {
                                  int bandId = state.band.id;
                                  if (!state.band.isPublic) {
                                    if (state.band.status == '') {
                                      bloc.add(ClickJoin(bandId));
                                    } else {
                                      bloc.add(ClickLeaveCommunit(bandId));
                                    }
                                  } else {
                                    if (state.band.status == '') {
                                      bloc.add(ClickRequest(bandId));
                                    } else {
                                      bloc.add(ClickCancelRequest(bandId));
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 600),
                            padding: EdgeInsets.only(
                                bottom: kPadding,
                                left: kPadding,
                                right: kPadding,
                                top: MediaQuery.of(context).padding.top),
                            color: state.pi > highCover
                                ? context.moonColors!.piccolo
                                : Colors.transparent,
                            child: Row(
                              children: [
                                MoonButton.icon(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  buttonSize: MoonButtonSize.sm,
                                  borderRadius: BorderRadius.circular(100),
                                  backgroundColor: context.moonColors!.frieza
                                      .withOpacity(0.7),
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                kPadding.gap,
                                Expanded(
                                  child: state.pi > highCover
                                      ? Row(
                                          children: [
                                            CustomAvatar(
                                              image: state.band.cover,
                                              high: 35,
                                              width: 35,
                                            ),
                                            kPadding.gap,
                                            Text(
                                              state.band.name,
                                              style: context.moonTypography!
                                                  .heading.text20
                                                  .copyWith(
                                                      color: Colors.white),
                                            )
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                ),
                                if (state.band.status == "active" &&
                                    (state.band.permission.createQuestion ||
                                        state.band.permission.createDiscussion))
                                  MoonDropdown(
                                    dropdownAnchorPosition:
                                        MoonDropdownAnchorPosition.bottomRight,
                                    contentPadding: EdgeInsets.zero,
                                    maxWidth: 130,
                                    onTapOutside: () {
                                      bloc.add(ClickOutsiteCreatePost());
                                    },
                                    show: state.showPost,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (state
                                            .band.permission.createQuestion)
                                          MoonButton(
                                            leading: Icon(MoonIcons
                                                .generic_edit_24_regular),
                                            label: Text(t.common.question),
                                            onTap: () {
                                              bloc.add(ClickCreateQuestion(
                                                  state.band));
                                            },
                                          ),
                                        if (state
                                            .band.permission.createDiscussion)
                                          MoonButton(
                                            leading: Icon(
                                                MoonIcons.chat_chat_24_regular),
                                            label: Text(t.common.discussion),
                                            onTap: () {
                                              bloc.add(ClickCreateDiscussion(
                                                  state.band));
                                            },
                                          ),
                                      ],
                                    ),
                                    child: MoonButton.icon(
                                      buttonSize: MoonButtonSize.sm,
                                      borderRadius: BorderRadius.circular(100),
                                      backgroundColor: context
                                          .moonColors!.frieza
                                          .withOpacity(0.7),
                                      onTap: () {
                                        if (token.isEmpty) {
                                          appRoute.push(AppRouteInfo.login());
                                        } else {
                                          bloc.add(ClickPost());
                                        }
                                      },
                                      icon: Icon(
                                        MoonIcons.controls_plus_16_regular,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                kPadding.gap,
                                MoonButton.icon(
                                  buttonSize: MoonButtonSize.sm,
                                  borderRadius: BorderRadius.circular(100),
                                  backgroundColor: context.moonColors!.frieza
                                      .withOpacity(0.7),
                                  onTap: () async {
                                    await MorebandButtomSheet.showBottomSheet(
                                        context, state.band, (value) {
                                      Navigator.pop(context);
                                      switch (value) {
                                        case morebandEnum.click:
                                          break;
                                        case morebandEnum.leave:
                                          bloc.add(ClickLeaveCommunit(
                                              state.band.id));
                                          break;
                                        case morebandEnum.deleteAndLeave:
                                          bloc.add(ClickDeleteAndLeave(
                                              state.band.id));
                                          break;
                                        case morebandEnum.manageCommmunity:
                                          bloc.add(ClickManageband(state.band));
                                        case morebandEnum.viewbandInfo:
                                          bloc.add(
                                              ClickViembandinfo(state.band));
                                          break;
                                        case morebandEnum.share:
                                          bloc.add(ClickShare());
                                          break;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
