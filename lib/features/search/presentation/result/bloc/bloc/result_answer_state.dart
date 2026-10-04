part of 'result_answer_bloc.dart';

@freezed
class ResultAnswerState extends BaseState with _$ResultAnswerState {
  const factory ResultAnswerState.initial(
      {@Default(false) bool isLoaing,
      @Default([]) List<AnswertEntity> answer,
      @Default([]) List<AnswertEntity> recentSearch,
      @Default(1) int page,
      @Default(true) bool isMorePage}) = _Initial;
}
