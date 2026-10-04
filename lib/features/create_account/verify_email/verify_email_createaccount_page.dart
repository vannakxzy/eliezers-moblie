import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/helper/fuction.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_otp_screen.dart';
import 'bloc/verify_email_createaccount_bloc.dart';

@RoutePage()
class VerifyEmailCreateaccountPage extends StatefulWidget {
  final String email;
  final String name;
  final String password;
  const VerifyEmailCreateaccountPage(
      {super.key,
      required this.email,
      required this.name,
      required this.password});

  @override
  State<VerifyEmailCreateaccountPage> createState() =>
      _VerifyEmailCreateaccountPageState();
}

class _VerifyEmailCreateaccountPageState extends BasePageBlocState<
    VerifyEmailCreateaccountPage, VerifyEmailCreateaccountBloc> {
  @override
  void initState() {
    bloc.add(InitPageEvent(widget.email));
    super.initState();
  }

  final otpController = TextEditingController();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: BlocBuilder<VerifyEmailCreateaccountBloc,
            VerifyEmailCreateaccountState>(
          builder: (context, state) {
            return CustomOtpScreen(
              mainTitle: t.common.verifyOtp,
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
                bloc.add(ClickVerityEvent(email: state.email, otp: value));
              },
              title: "${t.common.enterOtpsendtoEmail} ${state.email}",
            );
          },
        ),
      ),
    );
  }
}
