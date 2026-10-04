part of 'select_audience_bloc.dart';

@freezed
class SelectAudienceState extends BaseState with _$SelectAudienceState {
  const factory SelectAudienceState.initial({
    @Default('') String audience,
    @Default('') String oldAudience,
    @Default(false) bool isSetDefault,
  }) = _Initial;
}
