part of 'band_detail_bloc.dart';

@freezed
class bandDetailState extends BaseState with _$bandDetailState {
  const factory bandDetailState.initial({
    @Default(BandEntity()) BandEntity band,
    @Default([]) List<QuestionEntity> questions,
    @Default(true) bool loaingQuestion,
    @Default(false) bool isAnonyMous,
    @Default(true) bool isMorePage,
    @Default(false) bool showPost,
    @Default(FilterEntity()) FilterEntity filter,
    @Default(1) int page,
    @Default(1) double pi,
  }) = _Initial;
}
