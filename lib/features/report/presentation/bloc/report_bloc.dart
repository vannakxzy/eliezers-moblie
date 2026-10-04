// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import '../../domain/entities/report_type_entity.dart';
import '../../domain/usecase/create_report_usecase.dart';
import '../../domain/usecase/get_report_type_detail_usecase.dart';
import '../../domain/usecase/get_report_type_usecase.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../domain/entities/report_type_detail_entity.dart';

part 'report_event.dart';
part 'report_state.dart';
part 'report_bloc.freezed.dart';

@Injectable()
class ReportBloc extends BaseBloc<ReportEvent, ReportState> {
  ReportBloc(
    this._getReportTypeUseCase,
    this._getReportTypeDetialUseCase,
    this._createReportUsecase,
  ) : super(const _Initial()) {
    on<InitPage>(_getReportType);
    on<GetReportTypeDetailEvent>(_getReportTypeDetail);
    on<MessageChangedEvent>(_onMessageChanged);
    on<ClickReportTypeDetailEvent>(_clickReportDetail);
    on<PageChangeEvent>(_pageChanged);
    on<ClickCreateReportEvent>(_clickCreateReport);
    on<ClickReportTypeEvent>(_clickReportType);
  }
  final GetReportTypeUseCase _getReportTypeUseCase;
  final GetReportTypeDetialUseCase _getReportTypeDetialUseCase;
  final CreateReportUsecase _createReportUsecase;
  FutureOr<void> _pageChanged(
      PageChangeEvent event, Emitter<ReportState> emit) async {
    emit(state.copyWith(page: event.index));
  }

  FutureOr<void> _clickCreateReport(
      ClickCreateReportEvent event, Emitter<ReportState> emit) async {
    await runAppCatching(
      () async {
        String reason = '';
        reason = reason + state.selectedReportDetail.join();
        appRoute.pop();
        await _createReportUsecase.excecute(ReportInput(
          question_id: state.questionId,
          comment_id: state.commendId,
          answer_id: state.answerId,
          user_id: state.userId,
          reason: reason,
          type_key: state.reportType[event.typeIndex].id!,
        ));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _getReportType(
      InitPage event, Emitter<ReportState> emit) async {
    await runAppCatching(() async {
      emit(state.copyWith(getloadinReport: true));
      final report = await _getReportTypeUseCase.excecute('');
      final getloadingReportDetail = List.filled(report.length, false);
      List<List<ReportTypeDetailEntity>> reportDetail =
          List.filled(report.length, []);
      emit(state.copyWith(
          commendId: event.commentId,
          answerId: event.answerId,
          questionId: event.questionId,
          userId: event.userId,
          reportType: report,
          getloadinReport: false,
          getloadingReportDetail: getloadingReportDetail,
          reportTypeDetail: reportDetail));
    });
  }

  FutureOr<void> _getReportTypeDetail(
      GetReportTypeDetailEvent event, Emitter<ReportState> emit) async {
    await runAppCatching(
      () async {
        int id = state.reportType[event.index].id!;
        final reportDetail = [...state.reportTypeDetail];
        if (reportDetail[event.index].isEmpty) {
          final loading = [...state.getloadingReportDetail];
          loading[event.index] = true;
          emit(state.copyWith(getloadingReportDetail: loading));
          final data = await _getReportTypeDetialUseCase.excecute(id);
          reportDetail[event.index] = data;
          loading[event.index] = false;
          emit(state.copyWith(
              reportTypeDetail: reportDetail, getloadingReportDetail: loading));
        } else {
          debugPrint("fetch done not fetch again ");
        }
      },
      onError: (error) async {
        final loading = [...state.getloadingReportDetail];
        loading[event.index] = false;
        emit(state.copyWith(getloadingReportDetail: loading));
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _onMessageChanged(
      MessageChangedEvent event, Emitter<ReportState> emit) async {
    emit(state.copyWith(message: event.value));
  }

  FutureOr<void> _clickReportType(
      ClickReportTypeEvent event, Emitter<ReportState> emit) async {
    emit(state.copyWith(selectIndex: event.index));
  }

  FutureOr<void> _clickReportDetail(
      ClickReportTypeDetailEvent event, Emitter<ReportState> emit) async {
    final selectList = [...state.selectedReportDetail];
    selectList.contains(event.name)
        ? selectList.remove(event.name)
        : selectList.add(event.name);
    emit(state.copyWith(selectedReportDetail: selectList));
  }
}
