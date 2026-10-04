import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../core/utils/widgets/custom_textfield.dart';
import '../bloc/bloc.dart';

@RoutePage()
class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState
    extends BasePageBlocState<CreateAccountPage, CreateAccountBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ""),
      body: SingleChildScrollView(
        padding: kScreenPadding.copyWith(top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.createAccount.title,
              style: context.moonTypography?.heading.text32,
            ),
            const Gap(kPadding / 2),
            Text(
              t.createAccount.description,
              style: context.moonTypography?.body.text16,
              textAlign: TextAlign.left,
            ),
            kPadding.gap,
            BlocBuilder<CreateAccountBloc, CreateAccountState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextfield(
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      hintText: t.common.email,
                      validator: (value) => value.isEmptyOrNull
                          ? t.createAccount.emailrequired
                          : null,
                      onChanged: (value) {
                        bloc.add(EmailChangedEvent(value));
                      },
                    ),
                    Space.kSpace,
                    CustomTextfield(
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      hintText: t.common.name,
                      validator: (value) =>
                          value.isEmptyOrNull ? t.common.name : null,
                      onChanged: (value) {
                        bloc.add(NameChangedEvent(value));
                      },
                    ),
                    Space.kSpace,
                    CustomTextfield(
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      hintText: t.common.password,
                      validator: (value) => value.isEmptyOrNull
                          ? t.createAccount.emailrequired
                          : null,
                      onChanged: (value) {
                        bloc.add(PasswordChangedEvent(value));
                      },
                    ),
                    if (state.emailTaken)
                      Padding(
                        padding: const EdgeInsets.only(top: kPadding),
                        child: Text(
                          t.common.emailtokened,
                          style: context.moonTypography!.body.text12
                              .copyWith(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),
            Space.kSpace,
            BlocBuilder<CreateAccountBloc, CreateAccountState>(
              builder: (context, state) {
                return CustomButtom(
                  buttonSize: MoonButtonSize.lg,
                  isFullWidth: true,
                  disable: state.validateButton,
                  title: t.createAccount.title,
                  onTap: () {
                    bloc.add(ClickCreateEventAccountEvent());
                  },
                  trailing: state.isLoading
                      ? const MoonCircularLoader(
                          color: Colors.white,
                          circularLoaderSize: MoonCircularLoaderSize.xs,
                        )
                      : null,
                );
              },
            ),
            Space.p2,
            // AppTextDivider(t.common.or),
            // Space.p2,
            // CustomGmailCard(
            //   ontap: () async {
            //     final kkk =
            //         await AuthGmailService.obj.signInWithGoogle().then((value) {
            //       // User user = value;
            //       debugPrint("value $value");
            //     }).onError(
            //       (error, stackTrace) {
            //         debugPrint("onerror :   $error");
            //       },
            //     );
            //     debugPrint("value $kkk");
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
