import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import '../../../report/domain/usecase/create_report_usecase.dart';

import '../../../../core/helper/fuction.dart';
import '../../../../gen/i18n/translations.g.dart';

part 'display_image_event.dart';
part 'display_image_state.dart';
part 'display_image_bloc.freezed.dart';

@Injectable()
class DisplayImageBloc extends BaseBloc<DisplayImageEvent, DisplayImageState> {
  DisplayImageBloc(this._createReportUsecase) : super(const _Initial()) {
    on<ClickDownloadImage>(_clickDownImage);
    on<ClickReportImage>(_clickReport);
  }
  final CreateReportUsecase _createReportUsecase;
  FutureOr<void> _clickDownImage(
      ClickDownloadImage event, Emitter<DisplayImageState> emit) async {
    await runAppCatching(() async {
      appRoute.pop();
      debugPrint("image ${event.image}");
      await saveImage(event.image);
      appRoute.showSuccessSnackBar(t.common.downloadImageSuccess);
    }, onError: (value) async {
      debugPrint("your have error $value");
    });
  }

  FutureOr<void> _clickReport(
      ClickReportImage event, Emitter<DisplayImageState> emit) async {
    await runAppCatching(
      () async {
        appRoute.pop();
        await _createReportUsecase.excecute(
          event.report,
        );
        appRoute.showSuccessSnackBar(t.report.submitSuccess);
      },
      onError: (error) async {
        debugPrint("report erroro $error");
      },
    );
  }
}
