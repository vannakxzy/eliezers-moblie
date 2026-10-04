part of 'create_band_bloc.dart';

class CreatebandEvent extends BaseEvent {}

@freezed
class NameChanged extends CreatebandEvent with _$NameChanged {
  factory NameChanged(String value) = _NameChanged;
}

@freezed
class AuDientChangedEvent extends CreatebandEvent with _$AuDientChangedEvent {
  factory AuDientChangedEvent(String value) = _AuDientChanged;
}

@freezed
class InitPage extends CreatebandEvent with _$InitPage {
  factory InitPage() = _InitPage;
}

@freezed
class DesChanged extends CreatebandEvent with _$DesChanged {
  factory DesChanged(String value) = _DesChanged;
}

@freezed
class ClickCreatebandEvent extends CreatebandEvent with _$ClickCreatebandEvent {
  factory ClickCreatebandEvent() = _ClickCreateband;
}

@freezed
class ClickPickImageCamera extends CreatebandEvent with _$ClickPickImageCamera {
  factory ClickPickImageCamera() = _ClickPickImageCamera;
}

@freezed
class ClickPickImageGallery extends CreatebandEvent
    with _$ClickPickImageGallery {
  factory ClickPickImageGallery() = _ClickPickImageGallery;
}

@freezed
class ClickCrop extends CreatebandEvent with _$ClickCrop {
  factory ClickCrop() = _ClickCropEvent;
}

@freezed
class ClickClearImage extends CreatebandEvent with _$ClickClearImage {
  factory ClickClearImage() = _ClickClearImage;
}
