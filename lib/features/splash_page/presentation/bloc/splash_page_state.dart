part of 'splash_page_bloc.dart';

@freezed
class SplashPageState extends BaseState with _$SplashPageState {
  const factory SplashPageState({
    @Default('') String slogan,
  }) = _Initial;
}
