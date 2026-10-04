part of 'manage_band_bloc.dart';

@freezed
class ManageBandState extends BaseState with _$ManageBandState {
  const factory ManageBandState.initial({
    @Default('') String title,
    TextEditingController? titleController,
    @Default('') String des,
    @Default(false) bool enableSave,
    @Default(false) bool showPickImage,
    TextEditingController? desController,
    File? image,
    @Default(BandEntity()) BandEntity oldband,
    @Default(BandEntity()) BandEntity band,
    @Default(BandEntity()) BandEntity bandUpdated,
  }) = _Initial;
}
