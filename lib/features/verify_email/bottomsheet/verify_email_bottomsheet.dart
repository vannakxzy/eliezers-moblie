import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';
import '../../../core/helper/fuction.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_otp_screen.dart';
import '../presentation/bloc/verify_email_bloc.dart';

class VerifyEmailBottomsheet extends StatefulWidget {
  final String email;
  const VerifyEmailBottomsheet._({required this.email});

  static Future<bool?> show(BuildContext context, String email) =>
      showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (_) => VerifyEmailBottomsheet._(
          email: email,
        ),
      );

  @override
  State<VerifyEmailBottomsheet> createState() => _VerifyEmailBottomsheetState();
}

class _VerifyEmailBottomsheetState
    extends BasePageBlocState<VerifyEmailBottomsheet, VerifyEmailBloc> {
  @override
  void initState() {
    bloc.add(InitPageEvent(widget.email));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t.common.verifyOtp,
        isClose: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kPadding2),
          child: Column(
            children: [
              BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
                builder: (context, state) {
                  return Expanded(
                    child: CustomOtpScreen(
                      onChanged: (value) {
                        // bloc.add(const VerifyEmailEvent.onChange());
                      },
                      ontapReSend: () {
                        bloc.add(InitPageEvent(widget.email));
                      },
                      errorState: state.errorState,
                      validator: (value) {
                        unFocus();
                        bloc.add(ClickVerityEvent(
                          context: context,
                          email: widget.email,
                          otp: value,
                        ));
                        if (state.isloading == true) {}
                      },
                      title: "${t.common.sendOtpMessage} \n ${widget.email}",
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
