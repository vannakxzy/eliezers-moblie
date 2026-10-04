part of 'create_event_bloc.dart';

@freezed
class CreateEventState extends BaseState with _$CreateEventState {
  const factory CreateEventState({
    @Default('') String title,
    @Default('') String description,
    @Default([]) List<File> image,
    @Default('') String location,
    @Default(false) bool enableButton,
    @Default(false) bool isloading,
    @Default(0.0) double lat,
    @Default(0.0) double long,

    //--------------------------------
    DateTime? startDate,
    TimeOfDay? startTime,
    DateTime? endDate,
    TimeOfDay? endTime,
  }) = _Initial;
}
