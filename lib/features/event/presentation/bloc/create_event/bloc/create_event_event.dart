part of 'create_event_bloc.dart';

class CreateEventEvent extends BaseEvent {}

@freezed
class InitPage extends CreateEventEvent with _$InitPage {
  const factory InitPage() = _InitPage;
}

@freezed
class TitleChange extends CreateEventEvent with _$TitleChange {
  const factory TitleChange(String value) = _TitleChange;
}

@freezed
class DescriptionChanged extends CreateEventEvent with _$DescriptionChanged {
  const factory DescriptionChanged(String value) = _DescriptionChanged;
}

@freezed
class CoverChange extends CreateEventEvent with _$CoverChange {
  const factory CoverChange() = _CoverChange;
}

@freezed
class ClickDropLocation extends CreateEventEvent with _$ClickDropLocation {
  const factory ClickDropLocation() = _ClickDropLocation;
}

@freezed
class LocationChange extends CreateEventEvent with _$LocationChange {
  const factory LocationChange(String value) = _LocationChange;
}

@freezed
class ClickCreateEvent extends CreateEventEvent with _$ClickCreateEvent {
  const factory ClickCreateEvent() = _ClickCreateEvent;
}

@freezed
class GetLatLngFromMap extends CreateEventEvent with _$GetLatLngFromMap {
  const factory GetLatLngFromMap(double lat, double long) = _GetLatLngFromMap;
}

@freezed
class GetStartDate extends CreateEventEvent with _$GetStartDate {
  const factory GetStartDate(DateTime value) = _GetStartDate;
}

@freezed
class GetStartTime extends CreateEventEvent with _$GetStartTime {
  const factory GetStartTime(TimeOfDay value) = _GetStartTime;
}

@freezed
class GetEndDate extends CreateEventEvent with _$GetEndDate {
  const factory GetEndDate(DateTime value) = _GetEndDate;
}

@freezed
class GetEndTime extends CreateEventEvent with _$GetEndTime {
  const factory GetEndTime(TimeOfDay value) = _GetEndTime;
}

@freezed
class SelectCoverImage extends CreateEventEvent with _$SelectCoverImage {
  const factory SelectCoverImage() = _SelectCoverImage;
}
