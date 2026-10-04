import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/verify_otp_login_bloc.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../core/utils/widgets/custom_otp_screen.dart';

@RoutePage()
class VerifyOtpLoginPage extends StatefulWidget {
  final String email;
  final String password;
  const VerifyOtpLoginPage(
      {super.key, required this.email, required this.password});

  @override
  State<VerifyOtpLoginPage> createState() => _VerifyOtpLoginPageState();
}

class _VerifyOtpLoginPageState
    extends BasePageBlocState<VerifyOtpLoginPage, VerifyOtpLoginBloc> {
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
        child: BlocBuilder<VerifyOtpLoginBloc, VerifyOtpLoginState>(
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
              validator: (value) async {
                FocusScope.of(context).unfocus();
                unFocus();
                await Future.delayed(Duration(milliseconds: 100));
                bloc.add(ClickVerityEvent(
                    email: widget.email,
                    otp: value,
                    password: widget.password));
              },
              title: "${t.common.enterOtpsendtoEmail} ${state.email}",
            );
          },
        ),
      ),
    );
  }
}
