import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';

part 'create_music_event.dart';
part 'create_music_state.dart';
part 'create_music_bloc.freezed.dart';

@Injectable()
class CreateMusicBloc extends BaseBloc<CreateMusicEvent, CreateMusicState> {
  CreateMusicBloc() : super(_Initial()) {
    on<TitleChange>(_titleChange);
    on<DescriptionChange>(_desChange);
    on<ArtistChange>(_artistChange);
    on<AlbumChange>(_albumChange);
    on<GenreChange>(_genreChange);
    on<BpmChange>(_bpmChange);
    on<KeyChange>(_keyChange);
    on<CoverChange>(_coverChange);
    on<LyricsChange>(_lyricsChange);
  }
  FutureOr<void> _lyricsChange(
      LyricsChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(title: event.value));
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
    emit(state.copyWith(key: event.value));
  }

  FutureOr<void> _coverChange(
      CoverChange event, Emitter<CreateMusicState> emit) async {
    emit(state.copyWith(cover: event.value));
  }
}
