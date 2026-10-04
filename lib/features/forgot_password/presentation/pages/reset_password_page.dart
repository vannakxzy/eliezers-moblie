import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../bloc/bloc/reset_password_bloc.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String otp;
  const ResetPasswordPage({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState
    extends BasePageBlocState<ResetPasswordPage, ResetPasswordBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: t.securtyLogin.newPassword),
      body: SafeArea(
        child: Container(
          padding: kScreenPadding,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(t.securtyLogin.desChangePassword),
                    kPadding2.gap,
                    MoonFormTextInput(
                      hintText: t.securtyLogin.newPassword,
                      hasFloatingLabel: true,
                      textInputSize: MoonTextInputSize.xl,
                      onChanged: (value) {
                        bloc.add(PasswordChanged(value));
                      },
                      leading: const Icon(MoonIcons.security_key_32_regular),
                      helperPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
                  return CustomButtom(
                    isFullWidth: true,
                    title: t.common.ok,
                    onTap: () {
                      bloc.add(ClickConfirmEvent(widget.email, widget.otp));
                    },
                    disable: state.password.length >= 8 ? false : true,
                    trailing: state.isloading
                        ? const MoonCircularLoader(
                            color: Colors.white,
                            circularLoaderSize: MoonCircularLoaderSize.xs,
                          )
                        : null,
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
