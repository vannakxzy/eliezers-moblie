part of 'appearance_bloc.dart';

@freezed
class AppearanceState extends BaseState with _$AppearanceState {
  const factory AppearanceState.initial({
    @Default('') String theme,
    IconData? icon,
  }) = _Initial;
}
