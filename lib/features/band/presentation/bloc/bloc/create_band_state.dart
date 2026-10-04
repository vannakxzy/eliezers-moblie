part of 'create_band_bloc.dart';

@freezed
class CreateBandState extends BaseState with _$CreateBandState {
  const factory CreateBandState.initial({
    @Default('') String des,
    @Default('') String name,
    @Default('') String audience,
    File? image,
    File? originalImage,
    @Default(false) bool enableButton,
  }) = _Initial;
}
