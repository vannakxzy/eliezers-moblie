import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../musics/domain/usecase/get_musics_usercase.dart';

part 'select_music_event.dart';
part 'select_music_state.dart';
part 'select_music_bloc.freezed.dart';

@Injectable()
class SelectMusicBloc extends BaseBloc<SelectMusicEvent, SelectMusicState> {
  SelectMusicBloc(this._getmusicusecase) : super(_Initial()) {
    on<Seaching>(_searching);
  }
  final GetMusicssUsecase _getmusicusecase;

  FutureOr<void> _searching(
      Seaching event, Emitter<SelectMusicState> emit) async {
    await runAppCatching(() async {
      await _getmusicusecase.excecute(2);
    });
  }
}
