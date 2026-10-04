import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../bloc/bloc.dart';
import '../bloc/create_music_bloc.dart';
import '../widgets/musics_card.dart';

@RoutePage()
class CreateMusicPage extends StatefulWidget {
  const CreateMusicPage({super.key});
  @override
  State<CreateMusicPage> createState() => _CreateMusicPageState();
}

class _CreateMusicPageState
    extends BasePageBlocState<CreateMusicPage, CreateMusicBloc> {
  @override
  void initState() {
    // bloc.add(InitPage(1));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<MusicsBloc, MusicState>(
          builder: (context, state) {
            return Container(
              child: Column(
                children: [],
              ),
            );
          },
        ),
      ),
    );
  }
}
