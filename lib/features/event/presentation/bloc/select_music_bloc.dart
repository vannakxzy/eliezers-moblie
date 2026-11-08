import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../../data/models/musics/musics_model.dart';
import '../../../musics/domain/entities/musics_entity.dart';
import '../../../musics/domain/usecase/get_musics_usercase.dart';
import '../../../musics/domain/usecase/search_musics_usecase.dart';

part 'select_music_event.dart';
part 'select_music_state.dart';
part 'select_music_bloc.freezed.dart';

@Injectable()
class SelectMusicBloc extends BaseBloc<SelectMusicEvent, SelectMusicState> {
  SelectMusicBloc(this._getmusicusecase, this._searchMusic)
      : super(_Initial()) {
    on<Seaching>(_searching);
    on<ClickSelected>(_clickselectMusics);
    
  }
  final GetMusicssUsecase _getmusicusecase;
  final SearchMusicsUsecase _searchMusic;

  FutureOr<void> _searching(
      Seaching event, Emitter<SelectMusicState> emit) async {
    await runAppCatching(() async {
      if (event.text.isNotEmpty) {
        emit(state.copyWith(keyy: event.text));
        final musicsRepose = await _searchMusic.excecute(event.text);
        emit(state.copyWith(musics: []));
        final all = [...state.musics];
        all.addAll(musicsRepose.data.toListEntity());
        emit(state.copyWith(musics: all));
      }
    });
  }
  Future<void> _clickselectMusics(
      ClickSelected event, Emitter<SelectMusicState> emit) async {
    final musics = [...state.musics];
    final oldMusics = musics[event.index];
    musics[event.index] = oldMusics.copyWith(isSelected: !oldMusics.isSelected);
    emit(state.copyWith(musics: musics));
  }

}
