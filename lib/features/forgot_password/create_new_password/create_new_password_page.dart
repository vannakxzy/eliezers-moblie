import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_appbar.dart';

import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/utils/widgets/custom_buttom.dart';
import '../../../core/utils/widgets/custom_textfield.dart';
import '../../../gen/i18n/translations.g.dart';
import 'bloc/create_new_password_bloc_bloc.dart';

@RoutePage()
class CreateNewPasswordPage extends StatefulWidget {
  final String email;
  const CreateNewPasswordPage({super.key, required this.email});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends BasePageBlocState<
    CreateNewPasswordPage, CreateNewPasswordBlocBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: t.createNewPassword.title),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(kPadding2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.createNewPassword.description),
                    const Gap(kPadding2),
                    CustomTextfield(
                      hintText: "New Password",
                      autofocus: true,
                      onChanged: (value) {
                        bloc.add(PasswordChangedEvent(value));
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateNewPasswordBlocBloc,
                  CreateNewPasswordBlocState>(
                builder: (context, state) {
                  return CustomButtom(
                    trailing: state.isloading
                        ? const MoonCircularLoader(
                            color: Colors.white,
                            sizeValue: 20,
                          )
                        : const SizedBox(),
                    isFullWidth: true,
                    title: t.common.confirm,
                    onTap: () {
                      bloc.add(ClickCreateNewPassword(widget.email));
                    },
                    disable: state.password.length >= 6 ? false : true,
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
