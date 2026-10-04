import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/icon_constant.dart';
import '../../../../core/utils/widgets/custom_empty_data.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../core/utils/widgets/custom_see_more_page.dart';
import '../../buttomsheet/read_all_buttomsheet.dart';
import '../../domain/entities/notification_entity.dart';
import '../widgets/notification_card.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../bloc/bloc.dart';

@RoutePage()
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState
    extends BasePageBlocState<NotificationPage, NotificationBloc> {
  @override
  void initState() {
    bloc.add(GetNotification());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.notification.title),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (state.notification.isNotEmpty)
                        MoonButton.icon(
                          onTap: () async {
                            final read = await ReadAllButtomsheet.show(context);
                            if (read == true) {
                              bloc.add(ClickReadAll());
                            }
                          },
                          icon: Icon(MiconMoreHori, size: 20),
                        )
                    ],
                  ),
                ),
                Expanded(
                  child: AppSmartRefreshScrollView(
                    enableLoadMore:
                        state.isMorePage && state.page > 2 ? true : false,
                    onRefresh: () async {
                      bloc.add(RefreshPage());
                    },
                    onLoadMore: () async {
                      bloc.add(GetNotification());
                    },
                    child: state.isLoading && state.notification.isEmpty
                        ? Center(
                            child: CustomLoading(),
                          )
                        : state.notification.isEmpty
                            ? const Center(child: CustomEmptyData())
                            : ListView.separated(
                                // padding: EdgeInsets.only(top: kPadding),
                                itemBuilder: (context, index) {
                                  NotificationEntity notification =
                                      state.notification[index];
                                  return Column(
                                    children: [
                                      Dismissible(
                                        onDismissed: (direction) {
                                          bloc.add(
                                              ClickDeleteNotificaiton(index));
                                        },
                                        key: Key("$notification"),
                                        background: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: kPadding2),
                                          color: context.moonColors!.jiren,
                                          width: 120,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(t.common.delete,
                                                      style: context
                                                          .moonTypography!
                                                          .body
                                                          .text14
                                                          .copyWith(
                                                              color: Colors
                                                                  .white))),
                                            ],
                                          ),
                                        ),
                                        direction: DismissDirection.endToStart,
                                        child: NotificationCard(
                                          action: (value) {
                                            switch (value) {
                                              case NotificationEnum.tapAvatar:
                                                bloc.add(ClickAvatar(
                                                    notification.user!.id));
                                                break;
                                              case NotificationEnum.delete:
                                                bloc.add(
                                                    ClickDeleteNotificaiton(
                                                        index));
                                                break;
                                              case NotificationEnum.tap:
                                                bloc.add(
                                                    ClickNotification(index));
                                                break;
                                              case NotificationEnum
                                                    .hideThisType:
                                                bloc.add(ClickHideThisType(
                                                    notification.type));
                                                break;
                                              case NotificationEnum.report:
                                                bloc.add(ClickReport());
                                                break;
                                              case NotificationEnum.approveband:
                                                bloc.add(ClickApproveUserInband(
                                                    index));
                                                throw UnimplementedError();
                                              case NotificationEnum.rejectband:
                                                bloc.add(ClickRejectUserInband(
                                                    index));
                                            }
                                          },
                                          notification: notification,
                                        ),
                                      ),
                                      if (state.page == 2 &&
                                          state.isMorePage &&
                                          index ==
                                              state.notification.length - 1)
                                        CustomSeeMorePage(
                                            title: t.notification.seeprevious,
                                            ontap: () {
                                              bloc.add(GetNotification());
                                            })
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Gap(0),
                                itemCount: state.notification.length,
                              ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
