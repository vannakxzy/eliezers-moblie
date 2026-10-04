import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/fuction.dart';
import '../../../core/helper/local_data/storge_local.dart';
import 'bloc/verify_otp_change_password_bloc.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../../app/base/page/base_page_bloc_state.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_otp_screen.dart';

@RoutePage()
class VerifyotpChangePasswordPage extends StatefulWidget {
  final String password;
  const VerifyotpChangePasswordPage({super.key, required this.password});

  @override
  State<VerifyotpChangePasswordPage> createState() =>
      _VerifyotpChangePasswordPageState();
}

class _VerifyotpChangePasswordPageState extends BasePageBlocState<
    VerifyotpChangePasswordPage, VerifyOtpChangePasswordBloc> {
  @override
  void initState() {
    bloc.add(InitPageEventP());
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
          child: BlocBuilder<VerifyOtpChangePasswordBloc,
              VerifyOtpChangePasswordState>(
            builder: (context, state) {
              return CustomOtpScreen(
                errorState: state.errorState,
                isloading: state.isloading,
                onChanged: (value) {
                  bloc.add(OtpChangedEvent(value));
                },
                ontapReSend: () {
                  bloc.add(InitPageEventP());
                },
                validator: (value) {
                  unFocus();
                  bloc.add(ClickVerityEvent(value, widget.password));
                },
                title:
                    "${t.common.enterOtpsendtoEmail} ${LocalStorage.getStringValue(SharedPreferenceKeys.email)}",
              );
            },
          ),
        ),
      ),
    );
  }
}
