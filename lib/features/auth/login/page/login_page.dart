import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../bloc/login_bloc.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BasePageBlocState<LoginScreen, LoginBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: kScreenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.login.title,
                    style: context.moonTypography?.heading.text32,
                  ),
                  Text(
                    t.login.description,
                    style: context.moonTypography?.body.text18,
                    textAlign: TextAlign.left,
                  ),
                  const Gap(kPadding2),
                  Column(
                    children: [
                      MoonFormTextInput(
                        keyboardType: TextInputType.emailAddress,
                        enabled: !state.loading && !state.loadingGmail
                            ? true
                            : false,
                        hintText: t.common.email,
                        hasFloatingLabel: true,
                        textInputSize: MoonTextInputSize.xl,
                        onChanged: (value) {
                          bloc.add(EmailChangedEvent(value));
                        },
                        leading: const Icon(MoonIcons.mail_envelope_32_regular),
                      ),
                      const Gap(kPadding),
                      MoonFormTextInput(
                        enabled: !state.loading && !state.loadingGmail
                            ? true
                            : false,
                        hintText: t.common.password,
                        hasFloatingLabel: true,
                        textInputSize: MoonTextInputSize.xl,
                        onChanged: (value) {
                          bloc.add(PasswordChange(value));
                        },
                        leading: const Icon(MoonIcons.security_key_32_regular),
                        obscureText: state.showPassword,
                        helperPadding: EdgeInsets.zero,
                        trailing: IconButton(
                          visualDensity: VisualDensity.comfortable,
                          onPressed: () {
                            bloc.add(TogglePasswordVisibility());
                          },
                          icon: Icon(
                            state.showPassword
                                ? MoonIcons.controls_eye_32_regular
                                : MoonIcons.controls_eye_crossed_32_regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                  kPadding.gap,
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        bloc.add(ClickForgotPassword());
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Text(
                          "${t.forgetPassword.title}?",
                          style: context.moonTypography?.body.text12.copyWith(
                            // color: context.moonColors?.hit,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(kPadding2),
                  state.emailError != null || state.passwordError != null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: kPadding),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  t.login.worngPassword,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color: context.moonColors!.jiren),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  CustomButtom(
                    disable: !state.enableLogin,
                    buttonSize: MoonButtonSize.lg,
                    isFullWidth: true,
                    title: t.login.title,
                    onTap: () {
                      if (!state.loading) {
                        bloc.add(ClickButtonLogin());
                      }
                    },
                    trailing: state.loading
                        ? const MoonCircularLoader(
                            color: Colors.white,
                            circularLoaderSize: MoonCircularLoaderSize.xs,
                          )
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: kPadding2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Divider(
                            height: 0.5,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Text(
                            t.common.or,
                            style: context.moonTypography!.body.text18
                                .copyWith(color: context.moonColors!.trunks),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            height: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: MoonTextButton(
                      onTap: () {
                        // LocalStorage.storeData(
                        //     key: SharedPreferenceKeys.accessToken,
                        //     value:
                        //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3OTA4NjU2NDQsInJvbGUiOiJ1c2VyIiwic3ViIjoxLCJ1c2VybmFtZSI6InZhbm5hayJ9.Qs3aJdZq2p7ocET2Oxw1cDatgfzUhmq7F4cF2uJha0g");
                        bloc.add(ClickCreateEventAccountEvent());
                        // appRoute.push(AppRouteInfo.home());
                      },
                      height: kButtonHeight,
                      label: Text(
                        t.createAccount.title,
                        style: context.moonTypography!.heading.text18.copyWith(
                            // color: context.moonColors!.piccolo
                            ),
                      ),
                    ),
                  ),
                  // state.loadingGmail
                  //     ? const Center(child: CustomLoading())
                  //     : CustomGmailCard(
                  //         ontap: () {
                  //           bloc.add(ClickLoginWithEmail());
                  //         },
                  //       ),
                ],
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: SafeArea(
      //   top: false,
      //   minimum: const EdgeInsets.all(kPadding2),
      //   child: MoonTextButton(
      //     onTap: () {
      //       bloc.add(ClickCreateEventAccountEvent());
      //     },
      //     height: kButtonHeight,
      //     label: Text(
      //       t.createAccount.title,
      //       style: context.moonTypography!.heading.text18.copyWith(
      //           // color: context.moonColors!.piccolo
      //           ),
      //     ),
      //   ),
      // ),
    );
  }
}
