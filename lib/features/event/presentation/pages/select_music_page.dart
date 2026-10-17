import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/utils/widgets/custome_musics_card.dart';
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
                Row(
                  children: [],
                ),
                TextFormField(
                  onChanged: (value) {
                    bloc.add(Seaching(value));  
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.musics.length,
                    itemBuilder: (context, index) {
                      final music = state.musics[index];
                      return CustomeMusicsCard(
                        music: music,
                        onTapSelect: (value) {
                          bloc.add(ClickSelected(index));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
