part of 'data_tag_answer_bloc.dart';

@freezed
class DataTagAnswerState extends BaseState with _$DataTagAnswerState {
  const factory DataTagAnswerState({
    @Default([]) List<List<AnswertEntity>> answer,
    @Default([]) List<bool> isloading,
    @Default([]) List<bool> isMorePage,
    @Default([]) List<int> page,
  }) = _Initial;
}
