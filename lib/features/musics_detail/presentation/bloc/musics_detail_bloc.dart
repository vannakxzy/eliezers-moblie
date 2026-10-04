import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../core/helper/fuction.dart';
import '../../../musics/domain/entities/musics_entity.dart';
import '../../../musics/domain/usecase/creatre_favorite_usecase.dart';
import '../../../musics/domain/usecase/delete_favorite_usecase.dart';

part 'musics_detail_event.dart';
part 'musics_detail_state.dart';
part 'musics_detail_bloc.freezed.dart';

@Injectable()
class MusicsDetailBloc extends BaseBloc<MusicsDetailEvent, MusicsDetailState> {
  MusicsDetailBloc(this._createFavoriteUseCase, this._deleteFavoriteUseCase)
      : super(const _Initial()) {
    on<InitPage>(_initPage);
    on<ClickDownload>(_clickDownload);
    on<ClickShare>(_clickShare);
    on<ClickFavorite>(_clickFavorite);
  }

  final CreatreFavoriteUsecase _createFavoriteUseCase;
  final DeleteFavoriteUsecase _deleteFavoriteUseCase;
  FutureOr<void> _initPage(
      InitPage event, Emitter<MusicsDetailState> emit) async {
    emit(state.copyWith(musics: event.musics));
  }

  FutureOr<void> _clickDownload(
      ClickDownload event, Emitter<MusicsDetailState> emit) async {
    await downloadMp3(
        "https://i.pinimg.com/1200x/1a/36/38/1a363833061dfd02024185e2d95f5070.jpg",
        "me");
  }

  FutureOr<void> _clickFavorite(
      ClickFavorite event, Emitter<MusicsDetailState> emit) async {
    await runAppCatching(
      () async {
        if (state.musics!.isFavorite) {
          emit(state.copyWith(
              musics: state.musics!.copyWith(isFavorite: false)));
          await _deleteFavoriteUseCase.excecute(state.musics!.id);
        } else {
          emit(
              state.copyWith(musics: state.musics!.copyWith(isFavorite: true)));
          await _createFavoriteUseCase.excecute(state.musics!.id);
        }
      },
    );
  }

  Future<void> _clickShare(
      ClickShare event, Emitter<MusicsDetailState> emit) async {
    // await shareSong();
  }
}
