part of 'feedback_bloc.dart';

@freezed
class FeedbackState extends BaseState with _$FeedbackState {
  const factory FeedbackState({
    @Default('') String description,
    @Default(false) bool isLoading,
  }) = _Initial;
}
