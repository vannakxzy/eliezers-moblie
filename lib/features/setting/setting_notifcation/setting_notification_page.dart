import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/utils/widgets/custom_offon_setting.dart';
import 'bloc/setting_notification_bloc.dart';

@RoutePage()
class SettingNotificationPage extends StatefulWidget {
  const SettingNotificationPage({
    super.key,
  });

  @override
  State<SettingNotificationPage> createState() =>
      _SettingNotificationPageState();
}

class _SettingNotificationPageState extends BasePageBlocState<
    SettingNotificationPage, SettingNotificationBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(GetSettingEventP());
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t.notification.title,
      ),
      body: Container(
        padding: kScreenPadding,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<SettingNotificationBloc,
                  SettingNotificationState>(
                builder: (context, state) {
                  return state.loadingSetting == true
                      ? const Center(child: CustomLoading())
                      : state.setting != null
                          ? Column(
                              // spacing: kPadding,
                              children: [
                                CustomOffOnSetting(
                                  tilte: t.common.like,
                                  value: state.setting!.notification_like,
                                  onChanged: (value) {
                                    bloc.add(
                                      ClickUpdateSettingNotificationEvent(
                                          settingEnum.notificationLike),
                                    );
                                  },
                                ),
                                CustomOffOnSetting(
                                  tilte: t.common.comment,
                                  value: state.setting!.notification_comment,
                                  onChanged: (value) {
                                    bloc.add(
                                      ClickUpdateSettingNotificationEvent(
                                          settingEnum.notificationComment),
                                    );
                                  },
                                ),
                                CustomOffOnSetting(
                                  tilte: t.common.answer,
                                  value: state.setting!.notification_answer,
                                  onChanged: (value) {
                                    bloc.add(
                                      ClickUpdateSettingNotificationEvent(
                                          settingEnum.notificationAnswer),
                                    );
                                  },
                                ),
                                CustomOffOnSetting(
                                  tilte: t.common.correntAnswer,
                                  value: state.setting!.notification_correct,
                                  onChanged: (value) {
                                    bloc.add(
                                      ClickUpdateSettingNotificationEvent(
                                          settingEnum.notificationCorrect),
                                    );
                                  },
                                ),
                              ],
                            )
                          : Center(child: Text(t.common.somethingwasWrong));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
