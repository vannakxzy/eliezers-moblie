import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends BasePageBlocState<UsersPage, UsersBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            children: [
              MoonTextInput(
                hintText: t.common.user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
