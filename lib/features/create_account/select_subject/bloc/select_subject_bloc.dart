// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';

import '../../../../../features/home/domain/entities/subject_entity.dart';
import '../../domain/usecase/get_allsubject_usecase.dart';
import '../../domain/usecase/update_user_subject_usecase.dart';

part 'select_subject_event.dart';
part 'select_subject_state.dart';
part 'select_subject_bloc.freezed.dart';

@Injectable()
class SelectSubjectBloc
    extends BaseBloc<SelectSubjectEvent, SelectSubjectState> {
  SelectSubjectBloc(this._getAllSubjectUseCase, this._updateUserSubjectUsecase)
      : super(const _Initial()) {
    on<GetSubjectEvent>(_getAllSubject);
    on<ClickSkipEvent>(_onClickSkipEvent);
    on<ClickConfirmEvent>(_onClickComfirm);
    on<ClickSelectSubjectEvent>(_onClickSelectSubjectEvent);
  }
  final GetAllSubjectUseCase _getAllSubjectUseCase;
  final UpdateUserSubjectUsecase _updateUserSubjectUsecase;

  FutureOr<void> _onClickSelectSubjectEvent(
      ClickSelectSubjectEvent event, Emitter<SelectSubjectState> emit) {
    final List<int> select;
    select = [...state.selectedSucject];
    select.contains(event.id) ? select.remove(event.id) : select.add(event.id);
    emit(state.copyWith(selectedSucject: select));
  }

  FutureOr<void> _onClickSkipEvent(
      ClickSkipEvent event, Emitter<SelectSubjectState> emit) {
    appRoute.push(const AppRouteInfo.selectAvatar());
  }

  FutureOr<void> _onClickComfirm(
      ClickConfirmEvent event, Emitter<SelectSubjectState> emit) async {
    await runAppCatching(
      handleError: true,
      () async {
        emit(state.copyWith(loadingUpdateSubject: true));
        await _updateUserSubjectUsecase.excecute(state.selectedSucject);
        emit(state.copyWith(loadingUpdateSubject: false));
        appRoute.push(const AppRouteInfo.selectAvatar());
      },
    );
  }

  FutureOr<void> _getAllSubject(
      GetSubjectEvent event, Emitter<SelectSubjectState> emit) async {
    emit(state.copyWith(isloading: true));
    final subject = await _getAllSubjectUseCase.excecute('');
    emit(state.copyWith(subject: subject, isloading: false));
  }
}
