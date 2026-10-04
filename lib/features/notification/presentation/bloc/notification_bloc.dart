// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../../data/data_sources/remotes/notification_api_service.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import '../../../../data/models/notification/notification_model.dart';
import '../../../../data/models/profile/answer_model.dart';
import '../../../band/domain/usecase/approve_user_in_band_usecase.dart';
import '../../../band/domain/usecase/reject_user_in_band_usecase.dart';
import '../../../report/domain/usecase/create_report_usecase.dart';
import '../../domain/usecase/delete_notification_usecase.dart';
import '../../domain/usecase/get_notification_usecase.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecase/read_all_notification_usecase.dart';
import '../../domain/usecase/read_notification_usecase.dart';

part 'notification_bloc.freezed.dart';
part 'notification_event.dart';
part 'notification_state.dart';

@Injectable()
class NotificationBloc extends BaseBloc<NotificationEvent, NotificationState> {
  final GetNotificationUsecase _getNotificationUsecase;
  final DeleteNotificationUsecase _deleteNotificationUsecase;
  final CreateReportUsecase _createReportUsecase;
  final RejectUserInbandUsecase _rejectUserInbandUsecase;
  final ApproveUserInbandUsecase _approveUserInbandUsecase;
  final ReadNotificationUsecase _readNotificationUsecase;
  final ReadAllNotificationUsecase _readAllNotificationUsecase;
  NotificationBloc(
      this._getNotificationUsecase,
      this._deleteNotificationUsecase,
      this._readNotificationUsecase,
      this._createReportUsecase,
      this._readAllNotificationUsecase,
      this._approveUserInbandUsecase,
      this._rejectUserInbandUsecase)
      : super(_Initial()) {
    on<GetNotification>(_getNotification);
    on<RefreshPage>(_refreshPage);
    on<ClickReadAll>(_clickReadAll);
    on<ClickNotification>(_clickNofitication);
    on<ClickDeleteNotificaiton>(_clickDeleteNotifcation);
    on<ClickHideThisType>(_clickHideThisType);
    on<ClickAvatar>(_clickAvatar);
    on<ClickReport>(_clickCreateReport);
    on<ClickRejectUserInband>(_rejectUserInband);
    on<ClickApproveUserInband>(_clickApproveUserInband);
  }
  FutureOr<void> _getNotification(
      GetNotification event, Emitter<NotificationState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        final notificationRespose =
            await _getNotificationUsecase.excecute(state.page);
        List<NotificationEntity> all = [...state.notification];
        all.addAll(notificationRespose.data!.toListEntity());
        if (state.readAll) {
          all = all
              .map((notification) => notification.copyWith(readAt: true))
              .toList();
        }
        emit(state.copyWith(
            notification: all, isLoading: false, page: state.page + 1));
        debugPrint("**** page  ${notificationRespose.mate!.currentPage}");
        if (state.page > notificationRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
        debugPrint("error $error ");
      },
    );
  }

  FutureOr<void> _clickCreateReport(
      ClickReport event, Emitter<NotificationState> emit) async {
    await runAppCatching(
      () async {
        await _createReportUsecase
            .excecute(ReportInput(reason: "Notification", type_key: 0));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickReadAll(
      ClickReadAll event, Emitter<NotificationState> emit) async {
    await runAppCatching(
      () async {
        final notifications = [...state.notification];
        List<NotificationEntity> updatedNotifications = notifications
            .map((notification) => notification.copyWith(readAt: true))
            .toList();
        emit(state.copyWith(notification: updatedNotifications, readAll: true));
        await _readAllNotificationUsecase.excecute('');
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickApproveUserInband(
      ClickApproveUserInband event, Emitter<NotificationState> emit) async {
    await runAppCatching(
      () async {
        final notification = [...state.notification];
        final currentNotification = notification[event.index];
        notification[event.index] =
            currentNotification.copyWith(status: "approve");

        emit(state.copyWith(notification: notification));
        await _approveUserInbandUsecase.excecute(BandIdUserIdInput(
            user_id: currentNotification.user!.id,
            band_id: currentNotification.bandId,
            notification_id: currentNotification.id));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _rejectUserInband(
      ClickRejectUserInband event, Emitter<NotificationState> emit) async {
    await runAppCatching(
      () async {
        final notification = [...state.notification];
        final currentNotification = notification[event.index];
        notification[event.index] =
            currentNotification.copyWith(status: "reject");
        notification.removeAt(event.index);
        emit(state.copyWith(notification: notification));
        await _rejectUserInbandUsecase.excecute(BandIdUserIdInput(
            user_id: currentNotification.user!.id,
            band_id: currentNotification.bandId,
            notification_id: currentNotification.id));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _refreshPage(
      RefreshPage event, Emitter<NotificationState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(page: 1));
        emit(state.copyWith(isLoading: true, isMorePage: true));
        final notificationRespose =
            await _getNotificationUsecase.excecute(state.page);
        List<NotificationEntity> notificaitonDate =
            notificationRespose.data!.toListEntity();
        emit(state.copyWith(
            notification: notificaitonDate,
            page: state.page + 1,
            isLoading: false));
        if (state.page > notificationRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
        debugPrint("error $error ");
      },
    );
  }

  FutureOr<void> _clickNofitication(
      ClickNotification event, Emitter<NotificationState> emit) async {
    NotificationEntity notificaiton = state.notification[event.index];
    if (notificaiton.type.contains("band")) {
      appRoute.push(AppRouteInfo.otherProfile(userId: notificaiton.user!.id));
    } else {
      if (notificaiton.type == "comment_answer") {
        appRoute.push(AppRouteInfo.commentInAnswer(notificaiton.answerId,
            notificaiton.answer!.toEntity(), notificaiton.commentId, 0));
      } else {
        appRoute.push(AppRouteInfo.questionDetail(
          id: notificaiton.questionId,
          questionEntity: null,
          answerId: notificaiton.answerId,
          commentId: notificaiton.commentId,
        ));
      }
    }
    await runAppCatching(
      () async {
        List<NotificationEntity> notification = [...state.notification];
        NotificationEntity currentNotification = notification[event.index];
        notification[event.index] = currentNotification.copyWith(readAt: true);
        emit(state.copyWith(notification: notification));
        await _readNotificationUsecase.excecute(NotificationInput(
            id: currentNotification.id,
            type: currentNotification.type,
            comment_id: currentNotification.commentId,
            answer_id: currentNotification.answerId,
            question_id: currentNotification.questionId));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickDeleteNotifcation(
      ClickDeleteNotificaiton event, Emitter<NotificationState> emit) async {
    await runAppCatching(
      () async {
        List<NotificationEntity> notification = [...state.notification];
        NotificationEntity currentNotification = notification[event.index];
        notification.removeAt(event.index);
        emit(state.copyWith(notification: notification));
        await _deleteNotificationUsecase.excecute(NotificationInput(
            id: currentNotification.id,
            type: currentNotification.type,
            comment_id: currentNotification.commentId,
            answer_id: currentNotification.answerId,
            question_id: currentNotification.questionId));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickHideThisType(
      ClickHideThisType event, Emitter<NotificationState> emit) async {
    await runAppCatching(
      () async {
        List<NotificationEntity> notification = [...state.notification];
        notification
            .removeWhere((notification) => notification.type == event.type);
        emit(state.copyWith(notification: notification));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickAvatar(
      ClickAvatar event, Emitter<NotificationState> emit) async {
    appRoute.push(AppRouteInfo.otherProfile(userId: event.userId));
  }
}
