import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../data/models/musics/musics_model.dart';
import '../../domain/entities/musics_entity.dart';
import '../../domain/usecase/creatre_favorite_usecase.dart';
import '../../domain/usecase/delete_favorite_usecase.dart';
import '../../domain/usecase/get_musics_usercase.dart';

part 'musics_event.dart';
part 'musics_state.dart';
part 'musics_bloc.freezed.dart';

@Injectable()
class MusicsBloc extends BaseBloc<MusicsState, MusicState> {
  MusicsBloc(this._getMusicsUsecase, this._createFavoriteUseCase,
      this._deleteFavoriteUseCase)
      : super(const _Initial()) {
    on<InitPage>(_initPage);
    on<ClickMusics>(_clickMusics);
    on<ClickFavorite>(_clickFavorite);
    on<ClickRefreshPage>(_clickRefreshpage);
  }
  final GetMusicssUsecase _getMusicsUsecase;
  final CreatreFavoriteUsecase _createFavoriteUseCase;
  final DeleteFavoriteUsecase _deleteFavoriteUseCase;

  FutureOr<void> _initPage(InitPage event, Emitter<MusicState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true));
        final musicsRepose = await _getMusicsUsecase.excecute(event.page);
        final all = [...state.musics];
        all.addAll(musicsRepose.data.toListEntity());
        emit(state.copyWith(
            musics: all, isloading: false, page: state.page + 1));
        emit(
            state.copyWith(isMorePage: musicsRepose.pagination!.has_next_page));
      },
      onError: (error) async {
        debugPrint("error $error");
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _clickFavorite(
      ClickFavorite event, Emitter<MusicState> emit) async {
    await runAppCatching(
      () async {
        final musics = [...state.musics];
        MusicsEntity currectMusics = state.musics[event.index];
        if (currectMusics.isFavorite) {
          musics[event.index] = currectMusics.copyWith(isFavorite: false);
          emit(state.copyWith(musics: musics));
          await _deleteFavoriteUseCase.excecute(currectMusics.id);
        } else {
          musics[event.index] = currectMusics.copyWith(isFavorite: true);
          emit(state.copyWith(musics: musics));
          await _createFavoriteUseCase.excecute(currectMusics.id);
        }
      },
    );
  }

  FutureOr<void> _clickMusics(
      ClickMusics event, Emitter<MusicState> emit) async {
    final musics = state.musics[event.index];
    appRoute.push(AppRouteInfo.musicsDetail(musics));
  }

  FutureOr<void> _clickRefreshpage(
      ClickRefreshPage event, Emitter<MusicState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true, page: 1));
        final musicsRepose = await _getMusicsUsecase.excecute(1);
        emit(state.copyWith(
            musics: musicsRepose.data.toListEntity(),
            isloading: false,
            page: state.page + 1));
        emit(
            state.copyWith(isMorePage: musicsRepose.pagination!.has_next_page));
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }
}
