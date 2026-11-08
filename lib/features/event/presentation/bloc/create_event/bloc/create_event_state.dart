part of 'create_event_bloc.dart';

@freezed
class CreateEventState extends BaseState with _$CreateEventState {
  
  const factory CreateEventState({
    @Default('') String title,
    @Default('') String latlongText,
    TextEditingController? titleCon,
    TextEditingController? desCon,
    @Default('') String description,
    @Default([]) List<File> image,
    @Default('') String location,
    @Default(false) bool enableButton,
    @Default(false) bool isloading,
    @Default(false) bool isShowFillLatlong,
    @Default(0.0) double lat,
    @Default(0.0) double long,

    @Default([]) List<MusicsEntity> selectMusie,
    //--------------------------------
    DateTime? startDate,
    TimeOfDay? startTime,
    DateTime? endDate,
    TimeOfDay? endTime,
  }) = _Initial;
}
extension CreateEventStateExt on CreateEventState {
  bool get canCreate =>
      title.trim().isNotEmpty &&
      location.trim().isNotEmpty &&
      startDate != null &&
      startTime != null &&
      endDate != null &&
      image.isNotEmpty &&
      selectMusie.isNotEmpty &&
      endTime != null;

  CreateEventState clearAll() => copyWith(
        title: '',
        description: '',
        image: [],
        location: '',
        enableButton: false,
        isloading: false,
        isShowFillLatlong: false,
        lat: 0.0,
        long: 0.0,
        selectMusie: [],
        desCon: TextEditingController(),
        titleCon: TextEditingController(),
        startDate: null,
        startTime: null,
        endDate: null,
        endTime: null,
      );
}


