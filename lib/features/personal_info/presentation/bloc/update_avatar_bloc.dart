// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecase/update_profile_usecase.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../create_account/domain/entities/avatar_entity.dart';
import '../../../create_account/domain/usecase/get_avtar_usecase.dart';

part 'update_avatar_event.dart';
part 'update_avatar_state.dart';
part 'update_avatar_bloc.freezed.dart';

@Injectable()
class UpdateAvatarBloc extends BaseBloc<UpdateAvatarEvent, UpdateAvatarState> {
  UpdateAvatarBloc(this._getAvatarUsecase, this._updateProfileUsecase)
      : super(const UpdateAvatarState()) {
    on<GetAvatarEvent>(_getAvatar);
    on<ClickAvatarEvent>(_clickAvatar);
    on<ClickConfirmEvent>(_clickConfirm);
    on<ClickCancelEvent>(_clickCancel);
  }
  final GetAvatarUsecase _getAvatarUsecase;
  final UpdateProfileUsecase _updateProfileUsecase;

  FutureOr<void> _getAvatar(
      GetAvatarEvent event, Emitter<UpdateAvatarState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoadin: true));
        final avatar = await _getAvatarUsecase.excecute('');
        emit(state.copyWith(avatar: avatar, isLoadin: false));
      },
      onError: (error) async {
        debugPrint("error : $error");
      },
    );
  }

  FutureOr _clickAvatar(
      ClickAvatarEvent event, Emitter<UpdateAvatarState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  FutureOr _clickCancel(
      ClickCancelEvent event, Emitter<UpdateAvatarState> emit) {
    appRoute.pop();
  }

  FutureOr _clickConfirm(
      ClickConfirmEvent event, Emitter<UpdateAvatarState> emit) async {
    await runAppCatching(
      () async {
        String newAvatar = state.avatar[state.selectedIndex].name;
        await _updateProfileUsecase.excecute(newAvatar);
      },
      onError: (error) async {
        debugPrint("update avatar error $error");
      },
    );
  }
}
