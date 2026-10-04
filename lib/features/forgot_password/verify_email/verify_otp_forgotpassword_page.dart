import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/fuction.dart';
import 'bloc/verify_email_forgotpassword_bloc.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../../app/base/page/base_page_bloc_state.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_otp_screen.dart';

@RoutePage()
class VerifyOtpForgotpasswordPage extends StatefulWidget {
  final String email;
  const VerifyOtpForgotpasswordPage({
    super.key,
    required this.email,
  });

  @override
  State<VerifyOtpForgotpasswordPage> createState() =>
      _VerifyOtpForgotpasswordPageState();
}

class _VerifyOtpForgotpasswordPageState extends BasePageBlocState<
    VerifyOtpForgotpasswordPage, VerifyEmailForgotpasswordBloc> {
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
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kPadding2),
          child: Column(
            children: [
              BlocBuilder<VerifyEmailForgotpasswordBloc,
                  VerifyEmailForgotpasswordState>(
                builder: (context, state) {
                  return Expanded(
                    child: CustomOtpScreen(
                      onChanged: (value) {
                        bloc.add(OtpChangedEvent(otp: value));
                      },
                      ontapReSend: () {
                        bloc.add(InitPageEvent(widget.email));
                      },
                      isloading: state.isloading,
                      errorState: state.errorState,
                      validator: (value) {
                        unFocus();
                        bloc.add(ClickVerityEvent(
                          otp: value,
                        ));
                      },
                      title: "${t.common.enterOtpsendtoEmail} ${state.email}",
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
