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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              final file = await pickImage();
                              bloc.add(CoverChange(file));
                            },
                            child: Container(
                              height: MediaQuery.sizeOf(context).width / 3,
                              width: MediaQuery.sizeOf(context).width / 3,
                              decoration: BoxDecoration(
                                  image: state.cover != null
                                      ? DecorationImage(
                                          image: FileImage(state.cover!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  border: Border.all(
                                      color: context.moonColors!.beerus)),
                              child: Center(
                                child: Text(t.common.photo),
                              ),
                            ),
                          ),
                          kPadding.gap,
                          MoonFormTextInput(
                            controller: state.titleCon,
                            borderRadius: BorderRadius.circular(0),
                            // controller: TextEditingController(),
                            hintText: t.common.title,
                            onChanged: (value) {
                              bloc.add(TitleChange(value));
                            },
                            leading: const Icon(
                              MoonIcons.media_music_24_light,
                            ),
                          ),

                          kPadding.gap,

                          MoonFormTextInput(
                            controller: state.artistCon,
                            borderRadius: BorderRadius.circular(0),
                            // controller: TextEditingController(),
                            hintText: t.common.artist,
                            onChanged: (value) {
                              bloc.add(ArtistChange(value));
                            },
                            leading: const Icon(
                              MoonIcons.generic_user_24_light,
                            ),
                          ),
                          kPadding.gap,
                        
                          InkWell(
                            onTap: () async {
                              final result = await FilePicker.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['mp3'],
                                withData: true,
                              );
                              if (result == null || result.files.isEmpty)
                                return;
                              final PlatformFile data = result.files.first;
                              bloc.add(AudioChange(data));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: context.moonColors!.beerus)),
                              padding:
                                  EdgeInsets.symmetric(horizontal: kPadding),
                              alignment: Alignment.center,
                              width: state.audio == null
                                  ? MediaQuery.sizeOf(context).width / 4
                                  : MediaQuery.sizeOf(context).width,
                              height: 70,
                              // padding: EdgeInsets.all(kPadding2),
                              child: state.audio != null
                                  ? PlayerWidget(
                                      key: ValueKey(state.audio!.path),
                                      player: state.audioPlayer!,
                                      audioFile: state.audio!,
                                    )
                                  : Text(t.music.title),
                            ),
                          ),
                          kPadding.gap,
                          Text(t.music.chordSheet.toUpperCase()),
                          kPadding.gap,
                          MoonTextArea(
                            controller: state.chordSheetCon,
                            height: MediaQuery.sizeOf(context).height / 3,
                            borderRadius: BorderRadius.circular(0),
                            // controller: TextEditingController(),
                            hintText: "...",
                            onChanged: (value) {
                              bloc.add(ChordsheetChange(value));
                            },
                          ),
                          kPadding2.gap
                        ],
                      ),
                    ),
                  ),
                  CustomButtom(
                    isFullWidth: true,
                    onTap: () {
                      bloc.add(ClickCreate());
                    },
                    isloading: state.isloading,
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
