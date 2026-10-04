import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../bloc/select_music_bloc.dart';

@RoutePage()
class SelectMusicPage extends StatefulWidget {
  const SelectMusicPage({super.key});

  @override
  State<SelectMusicPage> createState() => _SelectMusicPageState();
}

class _SelectMusicPageState
    extends BasePageBlocState<SelectMusicPage, SelectMusicBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<SelectMusicBloc, SelectMusicState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: kScreenPadding,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    bloc.add(Seaching(1));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
