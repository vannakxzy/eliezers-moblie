import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/constants.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../../app/base/page/base_page_bloc_state.dart';

import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import '../../../core/utils/widgets/custom_offon_setting.dart';
import '../setting_notifcation/bloc/setting_notification_bloc.dart';
import 'bloc/privacy_data_bloc.dart';

@RoutePage()
class PrivacyDataPage extends StatefulWidget {
  const PrivacyDataPage({super.key});

  @override
  State<PrivacyDataPage> createState() => _PrivacyDataPageState();
}

class _PrivacyDataPageState
    extends BasePageBlocState<PrivacyDataPage, PrivacyDataBloc> {
  @override
  void initState() {
    bloc.add(GetSettingEvent());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: t.privacy.title,
        ),
        body: Container(
            padding: kScreenPadding,
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<PrivacyDataBloc, PrivacyDataState>(
                    builder: (context, state) {
                      return state.loading == true
                          ? const Center(
                              child: CustomLoading(),
                            )
                          : state.setting != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomOffOnSetting(
                                      tilte: t.privacy.privateAccount,
                                      value: state.setting!.private_account,
                                      onChanged: (value) {
                                        bloc.add(
                                          ClickUpdateSetting(
                                              settingEnum.privateAccount),
                                        );
                                      },
                                      subTitle: t.privacy.privateAccountDes,
                                    ),
                                    kPadding2.gap,
                                    CustomOffOnSetting(
                                      tilte: t.privacy.showActivity,
                                      value: state.setting!.show_aacl,
                                      onChanged: (value) {
                                        bloc.add(
                                          ClickUpdateSetting(
                                              settingEnum.showAacl),
                                        );
                                      },
                                    ),
                                    kPadding.gap,
                                    CustomOffOnSetting(
                                      tilte: t.privacy.showAnswer,
                                      value: state.setting!.show_answer,
                                      onChanged: (value) {
                                        bloc.add(
                                          ClickUpdateSetting(
                                              settingEnum.showAnswer),
                                        );
                                      },
                                    ),
                                    kPadding.gap,
                                    CustomOffOnSetting(
                                      tilte: t.privacy.showQuestion,
                                      value: state.setting!.show_question,
                                      onChanged: (value) {
                                        bloc.add(
                                          ClickUpdateSetting(
                                              settingEnum.showQuestion),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Text(t.common.somethingwasWrong),
                                );
                    },
                  ),
                )
              ],
            )));
  }
}
