import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';
part 'profile_entity.g.dart';

@freezed
class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    @Default('') String email,
    @Default('') String name,
    @Default('') String username,
    @Default('') String profile,
    @Default('') String bio,
    @Default(0) int totalAnswers,
    @Default(0) int totalQuestions,
    @Default(0) int totalFavourites,
    @Default('') String memberDate,
    @Default('') String bandRole,
    @Default(false) bool isYour,
    @Default(false) bool verify,
    @Default(0) int correctAnswers,
    @Default(0) int id,
  }) = _ProfileEntity;
  factory ProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileEntityFromJson(json);
}
