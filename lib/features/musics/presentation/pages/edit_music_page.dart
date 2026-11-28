import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../domain/entities/musics_entity.dart';
import '../bloc/edit_musice/edit_music_bloc.dart';
import '../widgets/mp3_url_widget.dart';

@RoutePage()
class EditMusicPage extends StatefulWidget {
  final MusicsEntity muisc;
  const EditMusicPage({super.key, required this.muisc});

  @override
  State<EditMusicPage> createState() => _EditMusicPageState();
}

class _EditMusicPageState
    extends BasePageBlocState<EditMusicPage, EditMusicBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(InitPage(widget.muisc));
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<EditMusicBloc, EditMusicState>(
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
                                  color: context.moonColors!.beerus,
                                  borderRadius: BorderRadius.circular(kRadius),
                                  image: state.cover != null
                                      ? DecorationImage(
                                          image: FileImage(state.cover!),
                                          fit: BoxFit.cover,
                                        )
                                      : state.coverUrl.isNotEmpty
                                          ? DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  state.coverUrl),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                  border: Border.all(
                                      color: context.moonColors!.beerus)),
                              child: state.cover != null ||
                                      state.coverUrl.isNotEmpty
                                  ? SizedBox()
                                  : Center(
                                      child: Text(t.common.photo),
                                    ),
                            ),
                          ),
                          kPadding.gap,
                          MoonFormTextInput(
                            backgroundColor: context.moonColors!.beerus,
                            keyboardType: TextInputType.emailAddress,
                            controller: state.titleCon,
                            borderRadius: BorderRadius.circular(kRadius),
                            // controller: TextEditingController(),
                            hintText: t.common.title,
                            onChanged: (value) {
                              bloc.add(TitleChange(value));
                            },
                          ),
                          kPadding.gap,
                          MoonFormTextInput(
                            backgroundColor: context.moonColors!.beerus,

                            controller: state.artistCon,
                            borderRadius: BorderRadius.circular(kRadius),
                            // controller: TextEditingController(),
                            hintText: t.common.artist,
                            onChanged: (value) {
                              bloc.add(ArtistChange(value));
                            },
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
                                  color: context.moonColors!.beerus,
                                  borderRadius: BorderRadius.circular(kRadius),
                                  border: Border.all(
                                      color: context.moonColors!.beerus)),
                              padding:
                                  EdgeInsets.symmetric(horizontal: kPadding),
                              alignment: Alignment.center,
                              width:
                                  state.audio == null && state.musicUrl.isEmpty
                                      ? MediaQuery.sizeOf(context).width / 4
                                      : MediaQuery.sizeOf(context).width,
                              height: 70,
                              // padding: EdgeInsets.all(kPadding2),
                              child: state.musicUrl.isNotEmpty
                                  ? Mp3UrlWidget(
                                      audioUrl: state.musicUrl,
                                    )
                                  : Text(t.music.title),
                            ),
                          ),
                          kPadding.gap,
                          Text(t.music.chordSheet.toUpperCase()),
                          kPadding.gap,
                          MoonTextArea(
                            backgroundColor: context.moonColors!.beerus,
                            controller: state.chordSheetCon,
                            height: MediaQuery.sizeOf(context).height / 3,
                            borderRadius: BorderRadius.circular(kRadius),
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
                    disable: !state.canUpdate,
                    isFullWidth: true,
                    onTap: () {
                      // CustomSnackBar.info(title: "sdfsdf");
                      // MoonToast.show(context,
                      //     backgroundColor: context.moonColors!.beerus,
                      //     toastAlignment: AlignmentGeometry.topRight,
                      //     label: Text(t.music.updateSuccess),
                      //     borderRadius: BorderRadius.circular(kRadius));
                      bloc.add(ClickUpdate(widget.muisc.id));
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
