part of 'edit_event_bloc.dart';

class EditEventEvent extends BaseEvent {}

@freezed
class InitPage extends EditEventEvent with _$InitPage {
  const factory InitPage(EventEntity event) = _InitPage;
}

@freezed
class TitleChange extends EditEventEvent with _$TitleChange {
  const factory TitleChange(String value) = _TitleChange;
}

@freezed
class DescriptionChanged extends EditEventEvent with _$DescriptionChanged {
  const factory DescriptionChanged(String value) = _DescriptionChanged;
}

@freezed
class CoverChange extends EditEventEvent with _$CoverChange {
  const factory CoverChange() = _CoverChange;
}

@freezed
class ClickDropLocation extends EditEventEvent with _$ClickDropLocation {
  const factory ClickDropLocation() = _ClickDropLocation;
}

@freezed
class LocationChange extends EditEventEvent with _$LocationChange {
  const factory LocationChange(String value) = _LocationChange;
}

@freezed
class ClickUpdateEvent extends EditEventEvent with _$ClickUpdateEvent {
  const factory ClickUpdateEvent() = _ClickUpdateEvent;
}

@freezed
class GetLatLngFromMap extends EditEventEvent with _$GetLatLngFromMap {
  const factory GetLatLngFromMap(double lat, double long) = _GetLatLngFromMap;
}

@freezed
class GetStartDate extends EditEventEvent with _$GetStartDate {
  const factory GetStartDate(DateTime value) = _GetStartDate;
}

@freezed
class GetStartTime extends EditEventEvent with _$GetStartTime {
  const factory GetStartTime(TimeOfDay value) = _GetStartTime;
}

@freezed
class GetEndDate extends EditEventEvent with _$GetEndDate {
  const factory GetEndDate(DateTime value) = _GetEndDate;
}

@freezed
class GetEndTime extends EditEventEvent with _$GetEndTime {
  const factory GetEndTime(TimeOfDay value) = _GetEndTime;
}

@freezed
class SelectCoverImage extends EditEventEvent with _$SelectCoverImage {
  const factory SelectCoverImage() = _SelectCoverImage;
}

@freezed
class ClickClearImage extends EditEventEvent with _$ClickClearImage {
  const factory ClickClearImage(int index) = _ClickClearImage;
}

@freezed
class GetMusic extends EditEventEvent with _$GetMusic {
  const factory GetMusic(List<MusicsEntity> music) = _GetMusic;
}

@freezed
class ClickRemoveMusic extends EditEventEvent with _$ClickRemoveMusic {
  const factory ClickRemoveMusic(int index) = _ClickRemoveMusic;
}

@freezed
class ClickCopyLatlong extends EditEventEvent with _$ClickCopyLatlong {
  const factory ClickCopyLatlong() = _ClickCopyLatlong;
}

@freezed
class CopylatlongChange extends EditEventEvent with _$CopylatlongChange {
  const factory CopylatlongChange(String value) = _CopylatlongChange;
}
