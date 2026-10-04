import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_offon_setting.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../domain/entities/band_entity.dart';
import '../bloc/bloc/band_permissions_bloc.dart';

@RoutePage()
class bandPermissionnPage extends StatefulWidget {
  final BandEntity band;
  const bandPermissionnPage({super.key, required this.band});

  @override
  State<bandPermissionnPage> createState() => _bandPermissionnPageState();
}

class _bandPermissionnPageState
    extends BasePageBlocState<bandPermissionnPage, bandPermissionsBloc> {
  @override
  void initState() {
    bloc.add(InitPage(widget.band.permission));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<bandPermissionsBloc, bandPermissionsState>(
      builder: (context, state) {
        return BlocBuilder<bandPermissionsBloc, bandPermissionsState>(
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                // appRoute.pop(result: state.permissionUpdated);
                Navigator.of(context).pop(state.permissionUpdated);
                return false;
              },
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(t.band.permission),
                    actions: [
                      MoonButton(
                        buttonSize: MoonButtonSize.lg,
                        textColor: state.isUpdate
                            ? context.moonColors!.piccolo
                            : context.moonColors!.trunks.withOpacity(0.6),
                        label: Text(t.common.save.toUpperCase()),
                        onTap: () {
                          if (state.isUpdate) {
                            bloc.add(ClickSave(widget.band.permission.id));
                          }
                        },
                      )
                    ],
                  ),
                  body: BlocBuilder<bandPermissionsBloc, bandPermissionsState>(
                    builder: (context, state) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: kPadding2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.band.whatMemberCando,
                              style: context.moonTypography!.body.text16
                                  .copyWith(color: context.moonColors!.trunks),
                            ),
                            kPadding2.gap,
                            AppDivider.large(),
                            kPadding.gap,
                            CustomOffOnSetting(
                              onChanged: (value) {
                                bloc.add(CreateQuestionChanged(value));
                              },
                              tilte: t.band.permissionCreateQuesiton,
                              value: state.permission.createQuestion,
                            ),
                            CustomOffOnSetting(
                              onChanged: (value) {
                                bloc.add(CreateDiscussionChange(value));
                              },
                              tilte: t.band.permissionCreateDiscussion,
                              value: state.permission.createDiscussion,
                            ),
                            CustomOffOnSetting(
                              onChanged: (value) {
                                bloc.add(AddMemberChanged(value));
                              },
                              tilte: t.band.addMember,
                              value: state.permission.addMember,
                            ),
                            CustomOffOnSetting(
                              onChanged: (value) {
                                bloc.add(SendMessageChanged(value));
                              },
                              tilte: t.band.permissionSendMessage,
                              value: state.permission.sendMessage,
                            ),
                            CustomOffOnSetting(
                              onChanged: (value) {
                                bloc.add(RecectionChanged(value));
                              },
                              tilte: t.band.permissionReaction,
                              value: state.permission.reaction,
                            ),
                            CustomOffOnSetting(
                              onChanged: (value) {
                                bloc.add(ChnageInfoChanged(value));
                              },
                              tilte: t.band.permissiionChangeInfo,
                              value: state.permission.changeInfo,
                            )
                          ],
                        ),
                      );
                    },
                  )),
            );
          },
        );
      },
    );
  }
}
