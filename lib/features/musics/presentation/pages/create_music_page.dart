import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../bloc/bloc.dart';
import '../bloc/create_music_bloc.dart';
import '../widgets/mp3_widget.dart';

@RoutePage()
class CreateMusicPage extends StatefulWidget {
  const CreateMusicPage({super.key});

  @override
  State<CreateMusicPage> createState() => _CreateMusicPageState();
}

class _CreateMusicPageState
    extends BasePageBlocState<CreateMusicPage, CreateMusicBloc> {

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<CreateMusicBloc, CreateMusicState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: kPadding2),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        MoonFormTextInput(
                          borderRadius: BorderRadius.circular(0),
                          // controller: TextEditingController(),
                          hintText: "Music title",
                          onChanged: (value) {
                            bloc.add(TitleChange(value));
                          },
                          leading: const Icon(
                            MoonIcons.media_music_24_light,
                          ),
                        ),

                        kPadding.gap,

                        MoonFormTextInput(
                          borderRadius: BorderRadius.circular(0),
                          // controller: TextEditingController(),
                          hintText: "Artist",
                          onChanged: (value) {
                            bloc.add(ArtistChange(value));
                          },
                          leading: const Icon(
                            MoonIcons.generic_user_24_light,
                          ),
                        ),

                        kPadding.gap,
                        // Pick MP3
                        MoonButton.icon(
                          onTap: () async {
                            final PlatformFile? data = await pickMp3();

                            // debugPrint("${data}");
                            // if (data == null || data.path == null) return;
                            // await state.audioPlayer?.setSource(
                            //   DeviceFileSource(data.path!),
                            // );
                            if (data != null) bloc.add(AudioChange(data));
                            // bloc.add()
                          },
                          icon: const Icon(
                            MoonIcons.files_add_24_regular,
                          ),
                        ),
                        Text("${state.audio?.path}"),
                        kPadding.gap,
                        if (state.audioPlayer != null)
                          PlayerWidget(
                            player: state.audioPlayer!,
                          )
                        // PlayerWidget(player: state.audioPlayer),
                      ],
                    ),
                  ),
                  CustomButtom(
                    isFullWidth: true,
                    onTap: () {
                      debugPrint("ddddddddddd");
                      bloc.add(ClickCreate());
                    },
                    title: t.common.create,
                  ),
                  kPadding.gap
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
