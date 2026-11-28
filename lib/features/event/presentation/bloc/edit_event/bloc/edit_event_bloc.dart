import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../../app/base/bloc/base_event.dart';
import '../../../../../../app/base/bloc/base_state.dart';
import '../../../../../../core/helper/fuction.dart';
import '../../../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../../../data/data_sources/remotes/event_api_service.dart';
import '../../../../../../gen/i18n/translations.g.dart';
import '../../../../../musics/domain/entities/musics_entity.dart';
import '../../../../domain/entities/event_entity.dart';
import '../../../../domain/usecase/update_event_use_case.dart';
part 'edit_event_event.dart';
part 'edit_event_state.dart';
part 'edit_event_bloc.freezed.dart';

@Injectable()
class EditEventBloc extends BaseBloc<EditEventEvent, EditEventState> {
  EditEventBloc(this._updateEventUseCase) : super(const EditEventState()) {
    on<InitPage>(_initPage);
    on<DescriptionChanged>(_desChange);
    on<TitleChange>(_titleChange);
    on<GetLatLngFromMap>(_getLatLngFromMap);
    on<ClickUpdateEvent>(_clickUpdateEvent);
    on<GetStartDate>(_getStartDate);
    on<GetEndDate>(_getEndDate);
    on<GetStartTime>(_getStartTime);
    on<GetEndTime>(_getEndTime);
    on<SelectCoverImage>(_selectCoverImage);
    on<ClickClearImage>(_clickclearImage);
    on<GetMusic>(_getMuise);
    on<ClickRemoveMusic>(_clickRemoveMusic);
    on<ClickCopyLatlong>(_clickCopyLatlong);
  }
  final UpdateEventUseCase _updateEventUseCase;
  FutureOr<void> _selectCoverImage(
      SelectCoverImage event, Emitter<EditEventState> emit) async {
    List<File> images = await pickMultipleImages();

    emit(state.copyWith(newEvent: state.newEvent.copyWith()));
  }

  FutureOr<void> _clickCopyLatlong(
      ClickCopyLatlong event, Emitter<EditEventState> emit) {
    emit(state.copyWith(isShowFillLatlong: !state.isShowFillLatlong));
    debugPrint("kkkkkkk ${state.isShowFillLatlong}");
  }

  FutureOr<void> _getStartDate(
      GetStartDate event, Emitter<EditEventState> emit) {
    emit(state.copyWith(startDate: event.value));
  }

  FutureOr<void> _getStartTime(
      GetStartTime event, Emitter<EditEventState> emit) {
    emit(state.copyWith(startTime: event.value));
  }

  FutureOr<void> _getEndDate(GetEndDate event, Emitter<EditEventState> emit) {
    emit(state.copyWith(endDate: event.value));
  }

  FutureOr<void> _getEndTime(GetEndTime event, Emitter<EditEventState> emit) {
    emit(state.copyWith(endTime: event.value));
  }

  FutureOr<void> _initPage(InitPage event, Emitter<EditEventState> emit) async {
    EventEntity eventtt = event.event;
    try {
      final DateTime parsedStartTime = DateTime.parse(eventtt.startTime);
      final String location =
          await getAddressFromLatLng(eventtt.latitude, eventtt.longitude);
      final DateTime parsedendDate = DateTime.parse(eventtt.endTime);
      final DateTime startDate = DateTime(
          parsedStartTime.year, parsedStartTime.month, parsedStartTime.day);
      final TimeOfDay startTime =
          TimeOfDay(hour: parsedStartTime.hour, minute: parsedStartTime.minute);
      final DateTime endDate =
          DateTime(parsedendDate.year, parsedendDate.month, parsedendDate.day);
      final TimeOfDay endTime =
          TimeOfDay(hour: parsedendDate.hour, minute: parsedendDate.minute);
      emit(state.copyWith(lat: 11.61531, long: 102.98380));
      emit(state.copyWith(oldEvent: eventtt));
      emit(state.copyWith(
        desCon: TextEditingController(text: eventtt.description),
        description: eventtt.description,
        titleCon: TextEditingController(text: eventtt.title),
        title: eventtt.title,
        location: location,
        selectMusie: eventtt.musics,
        startDate: startDate,
        startTime: startTime,
        endDate: endDate,
        endTime: endTime,
        imageUrl: eventtt.covers,
      ));
    } catch (value) {
      debugPrint("erroddddddddddr ${eventtt.startTime} ${eventtt.endTime}");
    }
  }

  FutureOr<void> _desChange(
      DescriptionChanged event, Emitter<EditEventState> emit) {
    emit(state.copyWith(
        newEvent: state.newEvent.copyWith(description: event.value)));
  }

  FutureOr<void> _titleChange(TitleChange event, Emitter<EditEventState> emit) {
    emit(state.copyWith(newEvent: state.newEvent.copyWith(title: event.value)));
  }

  FutureOr<void> _clickRemoveMusic(
      ClickRemoveMusic event, Emitter<EditEventState> emit) {
    List<MusicsEntity> musics = [...state.selectMusie];
    musics.removeAt(event.index);
    emit(state.copyWith(selectMusie: musics));
    emit(state.copyWith(newEvent: state.newEvent.copyWith(musics: musics)));
    _validarButton();
  }

  FutureOr<void> _clickclearImage(
      ClickClearImage event, Emitter<EditEventState> emit) {
    unFocus();
    List<File> images = [...state.covers];
    images.removeAt(event.index);
    emit(state.copyWith(covers: images));
    // emit(state.copyWith(
    //     newEvent: state.newEvent.copyWith(covers: state.covers)));
  }

  FutureOr<void> _getMuise(GetMusic event, Emitter<EditEventState> emit) {
    emit(state.copyWith(selectMusie: []));
    emit(state.copyWith(selectMusie: event.music));

    // emit(state.copyWith(
    //     newEvent: state.newEvent.copyWith(description: event.value)));
  }

  FutureOr<void> _clickUpdateEvent(
      ClickUpdateEvent event, Emitter<EditEventState> emit) async {
    await runAppCatching(
      () async {
        unFocus();
        try {
          emit(state.copyWith(isloading: true));
          final List<int> musicIds =
              state.selectMusie.map((music) => music.id).toList();
          final List<String> imagesBase64 = await Future.wait(
              state.covers.map((file) => imageToBase64(file)));
          final input = CreateEventInput(
            latitude: state.lat,
            longitude: state.long,
            title: state.title,
            description: state.description,
            cover: imagesBase64,
            start_time:
                combineDateAndTime("${state.startDate}", state.startTime!),
            end_time: combineDateAndTime("${state.endDate}", state.endTime!),
            music_ids: musicIds,
          );
          await _updateEventUseCase.excecute(input);
          CustomSnackBar.info(title: t.event.updateSuccess);
          emit(state.copyWith(isloading: false));
          emit(state.clearAll());
        } catch (value) {
          debugPrint("eeerroo $value");
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _getLatLngFromMap(
      GetLatLngFromMap event, Emitter<EditEventState> emit) async {
    unFocus();

    emit(state.copyWith(lat: event.lat, long: event.long));
    debugPrint("${event.lat} ${event.long}");
    final address = await getAddressFromLatLng(event.lat, event.long);
    emit(state.copyWith(location: address));
  }

  void _validarButton() {
    if (state.description.isNotEmpty && state.title.isNotEmpty) {}
  }
}
