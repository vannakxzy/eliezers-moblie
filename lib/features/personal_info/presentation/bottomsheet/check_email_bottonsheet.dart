import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../core/utils/widgets/custom_textfield.dart';
import '../bloc/personal_info_bloc.dart';
import '../../../verify_email/bottomsheet/verify_email_bottomsheet.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../gen/i18n/translations.g.dart';

class CheckEmailBottonsheet extends StatefulWidget {
  final PersonalInfoBloc myBloc;
  const CheckEmailBottonsheet({
    super.key,
    required this.myBloc,
  });

  static Future<String?> show(
    BuildContext context,
    PersonalInfoBloc myBloc,
  ) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        useSafeArea: true,
        builder: (_) => CheckEmailBottonsheet(
          myBloc: myBloc,
        ),
      );

  @override
  State<CheckEmailBottonsheet> createState() => _CheckEmailBottonsheetState();
}

class _CheckEmailBottonsheetState extends State<CheckEmailBottonsheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
    return Scaffold(
      appBar: CustomAppBar(
        title: t.updateEmail.title,
        isClose: true,
      ),
      body: BlocProvider.value(
        value: widget.myBloc,
        child: Container(
          padding: const EdgeInsets.only(
              left: kPadding2, right: kPadding2, bottom: kPadding2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Gap(kPadding),
                          Text(
                            t.updateEmail.des,
                            style: context.moonTypography!.body.text14,
                          ),
                          const Gap(kPadding),
                          CustomTextfield(
                            textInputType: TextInputType.emailAddress,
                            hintText: t.common.enterEmail,
                            autofocus: true,
                            onChanged: (value) {
                              debouncer.call(() {
                                widget.myBloc.add(
                                  ClickCheckEmail(
                                    value,
                                  ),
                                );
                              });
                            },
                          ),
                          const Gap(kPadding),
                          BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
                            builder: (context, state) {
                              if (checkStringIsgmail(
                                  value: state.emailCompea)) {
                                if (state.validateEmail == 1) {
                                  return Text(
                                    t.common.emailtokened,
                                  );
                                }
                                if (state.validateEmail == 0) {
                                  return Text(t.common.avalable);
                                }
                                return Text(t.common.checking);
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
                      builder: (context, state) => CustomButtom(
                          isFullWidth: true,
                          title: t.common.ok,
                          disable: state.emailCompea.length > 6 &&
                                  state.validateEmail == 0
                              ? false
                              : true,
                          onTap: () {
                            Navigator.pop(context, state.emailCompea);
                            Future.delayed(
                                const Duration(
                                  milliseconds: 1000,
                                ), () async {
                              await VerifyEmailBottomsheet.show(
                                  context, state.emailCompea);
                            });
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
