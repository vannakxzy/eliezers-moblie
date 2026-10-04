import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/utils/widgets/custom_textfield.dart';
import '../bloc/personal_info_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../gen/i18n/translations.g.dart';

class CheckUserNameButtonsheet extends StatefulWidget {
  final PersonalInfoBloc myBloc;
  const CheckUserNameButtonsheet({
    super.key,
    required this.myBloc,
  });

  static Future<bool?> show(
    BuildContext context,
    PersonalInfoBloc myBloc,
  ) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        useSafeArea: true,
        builder: (_) => CheckUserNameButtonsheet(
          myBloc: myBloc,
        ),
      );

  @override
  State<CheckUserNameButtonsheet> createState() =>
      _CheckUserNameButtonsheetState();
}

class _CheckUserNameButtonsheetState extends State<CheckUserNameButtonsheet> {
  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      bloc: widget.myBloc,
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            title: t.updateUserName.title,
            isClose: true,
          ),
          body: BlocProvider.value(
            value: widget.myBloc,
            child: Container(
              padding: kScreenPadding,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.updateUserName.des),
                        kPadding.gap,
                        CustomTextfield(
                          maxLength: 30,
                          hintText: t.common.enterUserName,
                          prefixIcon: const Icon(Icons.alternate_email_rounded),
                          autofocus: true,
                          onChanged: (value) {
                            debouncer.call(() {
                              widget.myBloc.add(
                                ClickCheckUserNameEvent(
                                  "@$value",
                                ),
                              );
                            });
                          },
                        ),
                        const Gap(kPadding),
                        Container(
                          alignment: Alignment.center,
                          child:
                              BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
                            builder: (context, state) {
                              if (state.userNameCompea.length > 6) {
                                if (state.validateUserName == 1) {
                                  return Text(t.common.emailtokened);
                                }
                                if (state.validateUserName == 0) {
                                  return Text(
                                    t.common.avalable,
                                    style: context.moonTypography!.body.text12,
                                  );
                                }
                                return Text(t.common.checking);
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButtom(
                      title: t.common.ok,
                      isFullWidth: true,
                      buttonSize: MoonButtonSize.md,
                      disable: state.userNameCompea.length > 6 &&
                              state.validateUserName == 0
                          ? false
                          : true,
                      onTap: () {
                        Navigator.pop(context, true);
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
