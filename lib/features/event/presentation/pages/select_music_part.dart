import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../core/utils/widgets/custome_musics_card.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../bloc/select_music_bloc.dart';

class SelectMusicPage extends StatefulWidget {
  const SelectMusicPage({super.key});
  @override
  State<SelectMusicPage> createState() => _SelectMusicPageState();
}

class _SelectMusicPageState
    extends BasePageBlocState<SelectMusicPage, SelectMusicBloc> {
  @override
  Widget buildPage(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: context.moonColors!.beerus,
      ),
    );
    return BlocBuilder<SelectMusicBloc, SelectMusicState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            top: false,
            child: Container(
              padding: kScreenPadding,
              child: Column(
                children: [
                  kPadding2.gap,
                  TextFormField(
                    maxLines: 1,
                    minLines: 1,
                    style: context.moonTypography!.body.text14.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: inputBorder,
                      enabledBorder: inputBorder,
                      isDense: true,
                      hintText: t.common.save,
                      hintStyle: context.moonTypography!.body.text16.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                  CustomButtom(
                    isFullWidth: true,
                    title: t.common.save,
                    onTap: () {
                      final selectMusic = state.musics
                          .where((music) => music.isSelected)
                          .toList();
                      Navigator.pop(context, selectMusic);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
