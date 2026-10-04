import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../core/utils/widgets/custom_textfield.dart';
import '../bloc/bloc.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends BasePageBlocState<ForgotPasswordPage, ForgotPasswordBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        minimum: kScreenPadding.copyWith(top: 0),
        child: Column(
          children: [
            Expanded(
                child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.forgetPassword.title,
                      style: context.moonTypography?.heading.text32,
                    ),
                    const Gap(kPadding),
                    CustomTextfield(
                      labelText: t.forgetPassword.description,
                      autofocus: true,
                      hintText: t.common.email,
                      textInputType: TextInputType.emailAddress,
                      onChanged: (value) {
                        bloc.add(EmailChangedEventEvent(value));
                      },
                    ),
                    if (state.isToken)
                      Padding(
                        padding: const EdgeInsets.only(top: kPadding),
                        child: Text(
                          t.common.emailNontoken,
                          style: context.moonTypography!.body.text12
                              .copyWith(color: context.moonColors!.jiren),
                        ),
                      ),
                    const Spacer(),
                    CustomButtom(
                      buttonSize: MoonButtonSize.lg,
                      isFullWidth: true,
                      title: t.common.ok,
                      onTap: () {
                        bloc.add(ClickConfirmEventEvent());
                      },
                      isloading: state.isLoading,
                      disable: !checkStringIsgmail(value: state.email),
                    ),
                    kPadding.gap,
                  ],
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
