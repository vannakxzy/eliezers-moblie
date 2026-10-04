import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../../../data/models/band/band_member_model.dart';
import '../../../domain/entities/band_entity.dart';
import '../../../domain/entities/band_member_entity.dart';
import '../../../domain/usecase/approve_user_in_band_usecase.dart';
import '../../../domain/usecase/get_all_request_usecase.dart';
import '../../../domain/usecase/reject_user_in_band_usecase.dart';

part 'member_request_event.dart';
part 'member_request_state.dart';
part 'member_request_bloc.freezed.dart';

@Injectable()
class MemberRequestBloc
    extends BaseBloc<MemberRequestEvent, MemberRequestState> {
  final GetAllRequestUsecase _getAllRequestUsecase;
  final RejectUserInbandUsecase _rejectUserInbandUsecase;
  final ApproveUserInbandUsecase _approveUserInbandUsecase;
  MemberRequestBloc(this._getAllRequestUsecase, this._rejectUserInbandUsecase,
      this._approveUserInbandUsecase)
      : super(_Initial()) {
    on<RefreshPage>(_refreshPage);
    on<InitPage>(_initPage);
    on<ClickApprove>(_clickApprove);
    on<ClickDetele>(_clickDelete);
    on<ClickProfile>(_clickProfile);
    on<Clickband>(_clickband);
  }
  FutureOr<void> _initPage(
      InitPage event, Emitter<MemberRequestState> emit) async {
    await runAppCatching(
      () async {
        try {
          emit(state.copyWith(isLoading: true));
          final response = await _getAllRequestUsecase
              .excecute(SearchInput(page: state.page, q: ''));
          List<bandMemberEntity> all = [...state.bandMember];
          all.addAll(response.data.toListEntity());
          emit(state.copyWith(
              isLoading: false, bandMember: all, page: state.page + 1));
          debugPrint("requestto join your band is ${state.bandMember.length}");
          if (state.page > response.mate!.lastPage) {
            emit(state.copyWith(isMorePage: false));
          }
        } catch (value) {
          debugPrint("you are on catch $value");
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
        debugPrint("you have been on catch $error");
      },
    );
  }

  FutureOr<void> _clickApprove(
      ClickApprove event, Emitter<MemberRequestState> emit) async {
    await runAppCatching(() async {
      final member = [...state.bandMember];
      final currentMember = member[event.index];
      member.removeAt(event.index);
      emit(state.copyWith(bandMember: member));
      await _approveUserInbandUsecase.excecute(BandIdUserIdInput(
          user_id: currentMember.user.id, band_id: currentMember.band.id));
    }, onError: (error) async {
      debugPrint("you get error $error");
    });
  }

  FutureOr<void> _clickDelete(
      ClickDetele event, Emitter<MemberRequestState> emit) async {
    await runAppCatching(() async {
      final member = [...state.bandMember];
      final currentMember = member[event.index];
      member.removeAt(event.index);
      emit(state.copyWith(bandMember: member));
      await _rejectUserInbandUsecase.excecute(BandIdUserIdInput(
          user_id: currentMember.user.id, band_id: currentMember.band.id));
    }, onError: (error) async {
      debugPrint("you get error $error");
    });
  }

  FutureOr<void> _clickProfile(
      ClickProfile event, Emitter<MemberRequestState> emit) async {
    appRoute.push(AppRouteInfo.otherProfile(userId: event.userId));
  }

  FutureOr<void> _clickband(
      Clickband event, Emitter<MemberRequestState> emit) async {
    appRoute.push(AppRouteInfo.bandDetail(event.band, event.band.id));
  }

  FutureOr<void> _refreshPage(
      RefreshPage event, Emitter<MemberRequestState> emit) async {
    await runAppCatching(() async {
      emit(state.copyWith(isLoading: true, isMorePage: true, page: 1));
      final response =
          await _getAllRequestUsecase.excecute(SearchInput(page: state.page));
      emit(state.copyWith(
          bandMember: response.data.toListEntity(),
          isLoading: false,
          page: state.page + 1));
      if (state.page > response.mate!.lastPage) {
        emit(state.copyWith(isMorePage: false));
      }
    }, onError: (error) async {
      emit(state.copyWith(isLoading: false));
      debugPrint("you get error $error");
    });
  }
}
