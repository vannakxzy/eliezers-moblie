// ignore_for_file: unused_field, void_checks

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../domain/usecase/get_other_profile_usecase.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecase/get_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@Injectable()
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._getProfileUsecase,
    this._getOtherProfileUseCase)
      : super(const _Initial()) {
    on<InitPageEvent>(_initpage);
  }
  final GetProfileUsecase _getProfileUsecase;
  final GetOtherProfileUseCase _getOtherProfileUseCase;

  FutureOr<void> _initpage(
      InitPageEvent event, Emitter<ProfileState> emit) async {
    if (event.userId > 0) {
      await runAppCatching(() async {
        /// get setting
        // emit(state.copyWith(loadingSetting: true));
        // final setting = await _getOtherSettingusecase.excecute(event.userId);
        // emit(state.copyWith(setting: setting, loadingSetting: false));

        /// get profile
        emit(state.copyWith(getProfileLoading: true));
        final profile = await _getOtherProfileUseCase.excecute(event.userId);
        emit(state.copyWith(profileEntity: profile, getProfileLoading: false));
        //-----------than------------------
        // if (!state.setting!.private_account || state.profileEntity.isYour) {
        //   add(GetTopTagEvent(event.userId));
        //   if (state.setting!.show_answer) {
        //     add(GetAnswerEvent(event.userId));
        //   }
        //   if (state.setting!.show_question) {
        //     add(GetQuestionEvent(event.userId));
        //   }
        // }
      });
    } else {
      await runAppCatching(() async {
        emit(state.copyWith(getProfileLoading: true));
        final profile = await _getProfileUsecase.excecute('');
        emit(state.copyWith(profileEntity: profile, getProfileLoading: false));
        // add(GetTopTagEvent(event.userId));
        // add(GetAnswerEvent(event.userId));
        // add(GetQuestionEvent(event.userId));
      }, onError: (error) async {
        emit(state.copyWith(getProfileLoading: false));
        debugPrint("error $error");
      });
    }
  }

}
