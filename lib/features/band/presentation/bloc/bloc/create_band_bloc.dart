// ignore_for_file: unused_field

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/fuction.dart';
import '../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../domain/usecase/create_band_usecase.dart';

part 'create_band_event.dart';
part 'create_band_state.dart';
part 'create_band_bloc.freezed.dart';

@Injectable()
class CreatebandBloc extends BaseBloc<CreatebandEvent, CreateBandState> {
  CreatebandBloc(this._createbandUsecase) : super(_Initial()) {
    on<DesChanged>(_desChange);
    on<NameChanged>(_nameChanged);
    on<ClickPickImageGallery>(_pickImageGallery);
    on<ClickPickImageCamera>(_pickImageCamera);
    on<InitPage>(_initPage);
    on<ClickClearImage>(_clearImage);
    on<ClickCreatebandEvent>(_clickCreateband);
    on<ClickCrop>(_cropImage);
    on<AuDientChangedEvent>(_audienceChanged);
  }
  final CreatebandUsecase _createbandUsecase;
  FutureOr<void> _desChange(DesChanged event, Emitter<CreateBandState> emit) {
    emit(state.copyWith(des: event.value));
    enableButton(emit);
  }

  FutureOr<void> _nameChanged(
      NameChanged event, Emitter<CreateBandState> emit) {
    emit(state.copyWith(name: event.value));
    enableButton(emit);
  }

  Future<void> _cropImage(
      ClickCrop event, Emitter<CreateBandState> emit) async {
    final croppedFile = await cropImage(state.originalImage!);
    emit(state.copyWith(image: croppedFile));
  }

  FutureOr<void> _initPage(
      InitPage event, Emitter<CreateBandState> emit) async {
    String audience =
        LocalStorage.getStringValue(SharedPreferenceKeys.audience);
    audience = audience.isEmpty ? "public" : audience;

    emit(state.copyWith(audience: audience));
  }

  FutureOr<void> _pickImageGallery(
      ClickPickImageGallery event, Emitter<CreateBandState> emit) async {
    final file = await pickImage(source: ImageSource.gallery);
    emit(state.copyWith(image: file, originalImage: file));
    enableButton(emit);
  }

  FutureOr<void> _clearImage(
      ClickClearImage event, Emitter<CreateBandState> emit) {
    emit(state.copyWith(image: null));
    enableButton(emit);
  }

  FutureOr<void> _audienceChanged(
      AuDientChangedEvent event, Emitter<CreateBandState> emit) async {
    emit(state.copyWith(audience: event.value));
  }

  FutureOr<void> _pickImageCamera(
      ClickPickImageCamera event, Emitter<CreateBandState> emit) async {
    final file = await pickImage(source: ImageSource.camera);
    emit(state.copyWith(image: file, originalImage: file));
    enableButton(emit);
  }

  FutureOr<void> _clickCreateband(
      ClickCreatebandEvent event, Emitter<CreateBandState> emit) async {
    if (state.enableButton) {
      await runAppCatching(
        () async {
          final image = await imageToBase64(state.image);
          final input = bandInput(
              name: state.name,
              description: state.des,
              image: image,
              is_private: state.audience == "private" ? true : false);
          // BandEntity band = BandEntity();
          // final band = await _createbandUsecase.excecute(input);
          appRoute.pop(result: input);

          // appRoute.showSuccessSnackBar(t.band.createSuccessMessage);
        },
        onError: (error) async {
          debugPrint("you have been on catch $error");
        },
      );
    }
  }

  void enableButton(Emitter<CreateBandState> emit) {
    if (state.name.isNotEmpty && state.des.isNotEmpty) {
      emit(state.copyWith(enableButton: true));
    } else {
      emit(state.copyWith(enableButton: false));
    }
  }
}
