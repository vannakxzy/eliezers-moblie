import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widgets/app_base_scaffold.dart';
import 'package:moon_design/moon_design.dart';

import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_buttom.dart';
import '../../../core/utils/widgets/custom_textfield.dart';
import '../../../gen/i18n/translations.g.dart';
import 'bloc/create_user_info_bloc.dart';

@RoutePage()
class CreateUserInfoPage extends StatefulWidget {
  final String email;
  final String otp;
  const CreateUserInfoPage({super.key, required this.email, required this.otp});

  @override
  State<CreateUserInfoPage> createState() => _CreateUserInfoPageState();
}

class _CreateUserInfoPageState
    extends BasePageBlocState<CreateUserInfoPage, CreateUserInfoBloc> {
  @override
  void initState() {
    bloc.add(InitialEvent(widget.email, widget.otp));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return AppBaseScaffold(
      appBar: AppBar(),
      title: t.createAccount.userInfo,
      description: t.createAccount.userInfoDes,
      bottomNavigationBar: BlocBuilder<CreateUserInfoBloc, CreateUserInfoState>(
        builder: (context, state) {
          return SafeArea(
            minimum: kScreenPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    MoonCheckbox(
                      value: state.confirmTnC,
                      onChanged: (value) {
                        bloc.add(ConfirmTnC(value));
                      },
                    ),
                    InkWell(
                      onTap: () {
                        bloc.add(ClickTermAndConfition());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: t.createAccount.iAgreeTo,
                          children: [
                            TextSpan(
                              text: t.createAccount.termCondition,
                              style:
                                  context.moonTypography?.body.text16.copyWith(
                                color: context.moonColors!.piccolo,
                              ),
                            ),
                          ],
                          style: context.moonTypography?.body.text16
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
                CustomButtom(
                  isloading: state.isLoading,
                  isFullWidth: true,
                  disable: !state.enableButton,
                  title: t.createAccount.title,
                  onTap: () {
                    if (!state.isLoading) {
                      bloc.add(ClickCreateAccountEvent());
                    }
                  },
                ),
                kPadding2.gap,
              ],
            ),
          );
        },
      ),
      child: BlocBuilder<CreateUserInfoBloc, CreateUserInfoState>(
        builder: (context, state) {
          return Column(
            children: [
              Column(
                children: [
                  CustomTextfield(
                    maxLength: 40,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    hintText: t.common.name,
                    // validator: (value) =>
                    //     value.isEmptyOrNull ? 'field is required!' : null,
                    onChanged: (value) {
                      bloc.add(NameChangedEvent(value));
                    },
                  ),
                  Space.kSpace,
                  BlocBuilder<CreateUserInfoBloc, CreateUserInfoState>(
                    builder: (context, state) {
                      return CustomTextfield(
                        hintText: t.common.password,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          bloc.add(PasswordChangedEvent(value));
                        },
                        obscureText: !state.showPassword,
                        trailing: IconButton(
                          visualDensity: VisualDensity.comfortable,
                          onPressed: () {
                            bloc.add(TogglePasswordEvent());
                          },
                          icon: Icon(
                            state.showPassword
                                ? MoonIcons.controls_eye_32_regular
                                : MoonIcons.controls_eye_crossed_32_regular,
                          ),
                        ),
                      );
                    },
                  ),
                  Space.kSpace,
                  BlocBuilder<CreateUserInfoBloc, CreateUserInfoState>(
                    builder: (context, state) => CustomTextfield(
                      hintText: t.common.confirmPassword,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        bloc.add(ConfirmPasswordChangedEvent(value));
                      },
                      obscureText: !state.showConfirmPassword,
                      trailing: IconButton(
                        visualDensity: VisualDensity.comfortable,
                        onPressed: () {
                          bloc.add(ToggleConfirmPasswordEvent());
                        },
                        icon: Icon(
                          state.showConfirmPassword
                              ? MoonIcons.controls_eye_32_regular
                              : MoonIcons.controls_eye_crossed_32_regular,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
