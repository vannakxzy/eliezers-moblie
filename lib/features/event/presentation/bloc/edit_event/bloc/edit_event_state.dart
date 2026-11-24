part of 'edit_event_bloc.dart';

@freezed
class EditEventState extends BaseState with _$EditEventState {
  const factory EditEventState({
    @Default('') String title,
    @Default('') String latlongText,
    TextEditingController? titleCon,
    TextEditingController? desCon,
    @Default('') String description,
    @Default([]) List<File> covers,
    @Default([]) List<String> imageUrl,
    @Default('') String location,
    @Default(false) bool enableButton,
    @Default(false) bool isloading,
    @Default(false) bool isShowFillLatlong,
    @Default(0.0) double lat,
    @Default(0.0) double long,
    @Default([]) List<MusicsEntity> selectMusie,
    @Default(EventEntity()) EventEntity oldEvent,
    @Default(EventEntity()) EventEntity newEvent,
    //--------------------------------
    DateTime? startDate,
    TimeOfDay? startTime,
    DateTime? endDate,
    TimeOfDay? endTime,
  }) = _Initial;
}

extension EditEventStateExt on EditEventState {
  bool get canUpdate => (title.trim().isNotEmpty &&
      location.trim().isNotEmpty &&
      startDate != null &&
      startTime != null &&
      endDate != null &&
      (covers.isNotEmpty || imageUrl.isNotEmpty) &&
      selectMusie.isNotEmpty &&
      endTime != null);

  EditEventState clearAll() => copyWith(
        title: '',
        description: '',
        covers: [],
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
