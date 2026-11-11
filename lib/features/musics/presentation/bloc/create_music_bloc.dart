import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/musics_api_service.dart';
import '../../domain/entities/musics_entity.dart';
import '../../domain/usecase/create_music_usecase.dart';
import '../../domain/usecase/get_musics_usercase.dart';

part 'create_music_event.dart';
part 'create_music_state.dart';
part 'create_music_bloc.freezed.dart';

@Injectable()
class CreateMusicBloc extends BaseBloc<CreateMusicEvent, CreateMusicState> {
  CreateMusicBloc(this._createMusicUsecase, this._getMusicUsecase)
      : super(_Initial()) {
    on<TitleChange>(_titleChange);
    on<DescriptionChange>(_desChange);
    on<ArtistChange>(_artistChange);
    on<AlbumChange>(_albumChange);
    on<GenreChange>(_genreChange);
    on<BpmChange>(_bpmChange);
    on<KeyChange>(_keyChange);
    on<CoverChange>(_coverChange);
    on<LyricsChange>(_lyricsChange);
    on<AudioChange>(_audioChange);
    on<ClickCreate>(_clickCreate);
    on<ChordsheetChange>(_chordsheetChange);
  }
  final CreateMusicUsecase _createMusicUsecase;
  final GetMusicssUsecase _getMusicUsecase;
  FutureOr<void> _lyricsChange(
      LyricsChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(title: event.value));
  }
  FutureOr<void> _chordsheetChange(
      ChordsheetChange event, Emitter<CreateMusicState> emit) {
    emit(state.copyWith(chord_sheet: event.value));
  }

  FutureOr<void> _audioChange(
      AudioChange event, Emitter<CreateMusicState> emit) async {
    final player = AudioPlayer();
    if (event.value.path == null) return;
    final File audioFile = File(event.value.path!);
    try {
      await player.setSource(
        DeviceFileSource(audioFile.path)
      );
      final timeMusic = await getAudioDuration(event.value);
      emit(state.copyWith(timeMusic: timeMusic));
      emit(state.copyWith(
        audio: audioFile,
        audioPlayer: player,
        platformFile: event.value,
      ));
    } catch (e) {
      debugPrint('Audio error: $e');
      await player.dispose();
    }
  }

  FutureOr<void> _clickCreate(
      ClickCreate event, Emitter<CreateMusicState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true));
        unFocus();
        try {
          final coverBase64 = await imageToBase64(state.cover);
          final String base64Audio = await ddddddd(state.platformFile);
          debugPrint("base64 : $base64Audio");
          final input = CreateMusicInput(
            title: state.title,
            description: state.description,
            cover: coverBase64,
            album: state.album,
            artist: state.artist,
            audio: base64Audio,
            chord_sheet: state.chord_sheet,
            lead_sheet: "",
          );
          await _createMusicUsecase.excecute(input);
          debugPrint("5. API request completed successfully");
          emit(state.cleardAll());
        } catch (e, stackTrace) {
          debugPrint("Upload error: $e");
          debugPrint("StackTrace: $stackTrace");
          rethrow;
        } finally {
          emit(state.copyWith(isloading: false));
        }
      },
    );
  }

  FutureOr<void> _titleChange(
      TitleChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(title: event.value));
  }

  FutureOr<void> _desChange(
      DescriptionChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(description: event.value));
  }

  FutureOr<void> _artistChange(
      ArtistChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(artist: event.value));
  }

  FutureOr<void> _albumChange(
      AlbumChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(album: event.value));
  }

  FutureOr<void> _genreChange(
      GenreChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(genre: event.value));
  }

  FutureOr<void> _bpmChange(
      BpmChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(bpm: event.value));
  }

  FutureOr<void> _keyChange(
      KeyChange event, Emitter<CreateMusicState> emit) async {
    // emit(state.copyWith(key: event.value));
  }

  FutureOr<void> _coverChange(
      CoverChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(cover: event.value));
  }
}
