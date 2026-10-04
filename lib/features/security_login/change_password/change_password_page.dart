import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_buttom.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../gen/i18n/translations.g.dart';
import 'bloc/change_password_bloc.dart';

@RoutePage()
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState
    extends BasePageBlocState<ChangePasswordPage, ChangePasswordBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: "${t.common.change} ${t.securtyLogin.pasword}"),
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
                        bloc.add(NewPasswordChangedEvent(value));
                      },
                      leading: const Icon(MoonIcons.security_key_32_regular),
                      helperPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                builder: (context, state) {
                  return CustomButtom(
                    isFullWidth: true,
                    title: t.common.ok,
                    onTap: () {
                      bloc.add(ClickConfirmEvent());
                    },
                    disable: !state.enableButton,
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
