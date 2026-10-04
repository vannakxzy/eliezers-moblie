part of 'all_answer_bloc.dart';

@freezed
class AllAnswerState extends BaseState with _$AllAnswerState {
  const factory AllAnswerState(
      {@Default([]) List<AnswertEntity> answer,
      @Default(false) bool isLoading,
      @Default(true) bool isMorePage,
      @Default(1) int page}) = _AllAnswerState;
}
