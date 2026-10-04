import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../widgets/answer_widget.dart';
import '../widgets/private_account_widget.dart';
import '../../../setting/domain/entities/setting_entity.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../notification/domain/entities/user_entity.dart';
import '../../alert/block_user_alert.dart';
import '../../bottomsheet/report_buttomsheet.dart';
import '../../domain/entities/profile_entity.dart';
import '../widgets/profile_data_empty.dart';
import '../../../setting/bottomsheet/profile_buttonsheet.dart';
import '../../../../core/constants/icon_constant.dart';
import '../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../core/utils/widgets/custom_anonymous_card.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../widgets/profile_shimmer.dart';
import '../widgets/question_widget.dart';
import '../widgets/title_widget.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../widgets/profile_widgets.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  final int userId;
  const ProfilePage({
    super.key,
    required this.userId,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageBlocState<ProfilePage, ProfileBloc> {
  @override
  void initState() {
    bloc.add(InitPageEvent(widget.userId));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: widget.userId > 0
              ? state.profileEntity.isYour
                  ? CustomAppBar(
                      title: t.common.yourProfile,
                      action: GestureDetector(
                          onTap: () {
                            debugPrint("dfssdf");
                            bloc.add(ClickShareUser());
                          },
                          child: const Icon(MiconSend)),
                    )
                  : CustomAppBar(
                      title: t.common.info,
                      action: GestureDetector(
                        onTap: () async {
                          final tap = await ProfileButtomSheet.showBottomSheet(
                              context: context);
                          final token = LocalStorage.getStringValue(
                              SharedPreferenceKeys.accessToken);
                          if (token.isEmpty && (tap != actionEnum.share)) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const CustomAnonymousCard();
                              },
                            );
                          } else {
                            if (tap == actionEnum.share) {
                              bloc.add(ClickShareUser());
                            }
                            if (tap == actionEnum.block) {
                              await BlockUserAlert.show(
                                  context: context,
                                  user: UserEntity(
                                      id: widget.userId,
                                      name: state.profileEntity.username));
                            }
                            if (tap == actionEnum.report) {
                              await ReportButtomsheet.show(
                                  context: context, userId: widget.userId);
                            }
                          }
                        },
                        child: const Icon(
                          MiconMoreHori,
                          size: 30,
                        ),
                      ),
                    )
              : AppBar(
                  leadingWidth: 300,
                  leading: Padding(
                    padding: const EdgeInsets.only(
                        left: kPadding2), // Adjust left padding if needed
                    child: Align(
                      alignment:
                          Alignment.centerLeft, // Ensure vertical centering
                      child: Text(
                        t.common.profile,
                        style: context.moonTypography!.heading.text20,
                      ),
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        bloc.add(ClickSettingEvent());
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0), // Adjust right padding
                        child: Icon(
                          MoonIcons.generic_settings_24_light,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: kPadding2, right: kPadding2),
              child: widget.userId == 0 || state.setting != null
                  ? AppSmartRefreshScrollView(
                      enableLoadMore: false,
                      onRefresh: () async {
                        bloc.add(InitPageEvent((widget.userId)));
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (state.profileEntity != ProfileEntity())
                              Container(
                                child: widget.userId == 0 ||
                                        state.profileEntity.isYour
                                    ? ProfileWidget(
                                        setting: SettingEntity(),
                                        isYour: true,
                                        profile: state.profileEntity,
                                      )
                                    : ProfileWidget(
                                        setting: state.setting!,
                                        profile: state.profileEntity,
                                      ),
                              ),
                            Text(state.profileEntity.name ?? ""),
                            if (state.profileEntity == ProfileEntity())
                              ProFileShimmer(),
                            if (state.toptag.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(kPadding),
                                  TitleWidget(
                                    title: t.common.favorite,
                                    ontap: () {
                                      bloc.add(ClickSeeAllQuestionEvent(
                                          widget.userId));
                                    },
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(kPadding),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: context.moonColors!.beerus)),
                                    child: Wrap(
                                      runAlignment: WrapAlignment.center,
                                      spacing: kPadding,
                                      runSpacing: kPadding,
                                      children: [
                                        ...List.generate(
                                            state.toptag.length > 10
                                                ? 10
                                                : state.toptag.length, (index) {
                                          final topTag = state.toptag[index];
                                          return GestureDetector(
                                              onTap: () {
                                                appRoute.push(
                                                    AppRouteInfo.dataTag(
                                                        index: index,
                                                        userId: widget.userId,
                                                        tag: state.toptag));
                                              },
                                              child: MoonTag(
                                                tagSize: MoonTagSize.xs,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: context
                                                      .moonColors!.beerus
                                                      .withOpacity(0.5),
                                                ),
                                                label: RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                    text: topTag.name,
                                                    style: context
                                                        .moonTypography!
                                                        .body
                                                        .text12
                                                        .copyWith(
                                                      color: context
                                                          .moonColors!.trunks,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: " x ${topTag.count}",
                                                    style: context
                                                        .moonTypography!
                                                        .body
                                                        .text10
                                                        .copyWith(
                                                      color: context
                                                          .moonColors!.trunks
                                                          .withOpacity(0.7),
                                                    ),
                                                  )
                                                ])),
                                              ));
                                        })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            if (state.question.isNotEmpty)
                              Column(
                                children: [
                                  kPadding.gap,
                                  TitleWidget(
                                    title: t.profileInfo.topQuestion,
                                    count: state.question.length,
                                    ontap: () {
                                      debugPrint("dsfdsf");
                                      bloc.add(ClickSeeAllQuestionEvent(
                                          widget.userId));
                                    },
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  context.moonColors!.beerus),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final question =
                                              state.question[index];
                                          return QuestionWidget(
                                              question: question,
                                              ontap: () {
                                                bloc.add(ClickQuestionEvetn(
                                                    question, question.id));
                                              });
                                        },
                                        separatorBuilder: (context, index) =>
                                            AppDivider.large(),
                                        itemCount: state.question.length > 5
                                            ? 5
                                            : state.question.length,
                                      )),
                                  kPadding2.gap,
                                ],
                              ),
                            if (state.answer.isNotEmpty)
                              Column(
                                children: [
                                  TitleWidget(
                                    title: t.profileInfo.topAnswer,
                                    count: state.answer.length,
                                    ontap: () {
                                      bloc.add(ClickSeeAllAnswerEvent(
                                          widget.userId));
                                    },
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  context.moonColors!.beerus),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final answer = state.answer[index];
                                          return AnswerWidget(
                                              answer: answer,
                                              ontap: () {
                                                bloc.add(
                                                    ClickAnswerEvent(answer));
                                              });
                                        },
                                        separatorBuilder: (context, index) =>
                                            AppDivider.large(),
                                        itemCount: state.question.length > 5
                                            ? 5
                                            : state.question.length,
                                      )),
                                ],
                              ),
                            if (state.isNothing)
                              ProfileDataEmpty(userId: widget.userId),
                            if (state.setting != null &&
                                state.setting!.private_account &&
                                widget.userId != 0 &&
                                !state.profileEntity.isYour &&
                                !state.getProfileLoading)
                              const Align(
                                  alignment:
                                      Alignment.center, // Centers horizontally
                                  child: PrivateAccountWidget()),
                            kPadding2.gap
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        );
      },
    );
  }
}
