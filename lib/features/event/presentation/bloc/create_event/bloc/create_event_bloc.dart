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
import '../../../../../../data/data_sources/remotes/event_api_service.dart';
import '../../../../../musics/domain/entities/musics_entity.dart';
import '../../../../domain/usecase/create_event_use_case.dart';
part 'create_event_event.dart';
part 'create_event_state.dart';
part 'create_event_bloc.freezed.dart';

@Injectable()
class CreateEventBloc extends BaseBloc<CreateEventEvent, CreateEventState> {
  CreateEventBloc(this._createEventUsecase) : super(const CreateEventState()) {
    on<InitPage>(_initPage);
    on<DescriptionChanged>(_desChange);
    on<TitleChange>(_titleChange);
    on<CoverChange>(_coverChange);
    on<GetLatLngFromMap>(_getLatLngFromMap);
    on<ClickCreateEvent>(_clickCreateEvent);
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
  final CreateEventUsecase _createEventUsecase;
  FutureOr<void> _copylatLongChange(
      CopylatlongChange event, Emitter<CreateEventState> emit) {

  }
  FutureOr<void> _selectCoverImage(
      SelectCoverImage event, Emitter<CreateEventState> emit) async {
    // await pickImage(source: ImageSource.camera);
    List<File> images = await pickMultipleImages();
    // List<File> data= [...state.image]
    emit(state.copyWith(image: images));

    // if (image != null) {
    //   emit(state.copyWith(image: [...state.image, image.file]));
    // }
  }

  FutureOr<void> _clickCopyLatlong(
      ClickCopyLatlong event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(isShowFillLatlong: !state.isShowFillLatlong));
    debugPrint("kkkkkkk ${state.isShowFillLatlong}");
  }
  FutureOr<void> _getStartDate(
      GetStartDate event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(startDate: event.value));
  }

  FutureOr<void> _getStartTime(
      GetStartTime event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(startTime: event.value));
  }

  FutureOr<void> _getEndDate(GetEndDate event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(endDate: event.value));
  }

  FutureOr<void> _getEndTime(GetEndTime event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(endTime: event.value));
  }

  FutureOr<void> _initPage(
      InitPage event, Emitter<CreateEventState> emit) async {
    emit(state.copyWith(lat: 11.61531, long: 102.98380));
    // Position location = await Geolocator.getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.high,
    // );
    debugPrint("locationwwwwwwwwww: ${state.lat} ${state.long}");
    // emit(state.copyWith(lat: location.latitude, long: location.longitude));
  }

  FutureOr<void> _desChange(
      DescriptionChanged event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(description: event.value));
    _validarButton();
  }

  FutureOr<void> _titleChange(
      TitleChange event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(title: event.value));
    _validarButton();
  }
  FutureOr<void> _clickRemoveMusic(
      ClickRemoveMusic event, Emitter<CreateEventState> emit) {
    List<MusicsEntity> musics = [...state.selectMusie];
    musics.removeAt(event.index);
    emit(state.copyWith(selectMusie: musics));
    debugPrint("dddddddddddd");
    _validarButton();
  }
  FutureOr<void> _clickclearImage(
      ClickClearImage event, Emitter<CreateEventState> emit) {
    unFocus();

    List<File> images = [...state.image];
    images.removeAt(event.index);
    emit(state.copyWith(image: images));
  }
  FutureOr<void> _coverChange(
      CoverChange event, Emitter<CreateEventState> emit) {
    // emit(state.copyWith(cover: event.value));
  }

  FutureOr<void> _getMuise(GetMusic event, Emitter<CreateEventState> emit) {
    //  emit(state.copy(s))
    emit(state.copyWith(selectMusie: []));
    emit(state.copyWith(selectMusie: event.music));
  }

  
  FutureOr<void> _clickCreateEvent(
      ClickCreateEvent event, Emitter<CreateEventState> emit) async {
    await runAppCatching(() async {
        unFocus();

        try {
          emit(state.copyWith(isloading: true));
          final List<int> musicIds =
              state.selectMusie.map((music) => music.id).toList();
          final List<String> imagesBase64 = await Future.wait(
            state.image.map((file) => imageToBase64(file)),
          );
      final input = CreateEventInput(
            latitude: state.lat,
            longitude: state.long,
        title: state.title,
            description: state.description,
            cover: imagesBase64,
        start_time: combineDateAndTime("${state.startDate}", state.startTime!),
        end_time: combineDateAndTime("${state.endDate}", state.endTime!),
            music_ids: musicIds,
      );
      await _createEventUsecase.excecute(input);
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

      GetLatLngFromMap event, Emitter<CreateEventState> emit) async {
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
