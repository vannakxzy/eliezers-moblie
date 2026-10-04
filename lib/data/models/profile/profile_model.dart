import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/profile/domain/entities/profile_entity.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  const ProfileModel(
      {this.totalQuestions,
      this.name,
      this.bio,
      this.username,
      this.profile,
      this.totalAnswers,
      this.totalFavorites,
      this.correctAnswers,
      this.memberDate,
      this.email,
      this.verify,
      this.id,
      this.bandRole,
      this.isYour});

  final String? bio;
  final String? name;
  final String? email;
  final String? profile;
  final bool? verify;
  final int? id;
  @JsonKey(name: 'user_name')
  final String? username;

  @JsonKey(name: 'count_answers')
  final int? totalAnswers;

  @JsonKey(name: 'count_questions')
  final int? totalQuestions;

  @JsonKey(name: 'count_favorite')
  final int? totalFavorites;

  @JsonKey(name: 'count_correct')
  final int? correctAnswers;

  @JsonKey(name: 'member_date')
  final String? memberDate;

  @JsonKey(name: 'band_role')
  final String? bandRole;

  @JsonKey(name: 'is_your')
  final bool? isYour;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

extension ToEntity on ProfileModel {
  ProfileEntity toEntity() => ProfileEntity(
      profile: profile ?? '',
      email: email ?? '',
      name: name ?? '',
      username: username ?? '',
      bandRole: bandRole ?? '',
      bio: bio ?? '',
      memberDate: memberDate ?? '',
      correctAnswers: correctAnswers ?? 0,
      totalFavourites: totalFavorites ?? 0,
      totalQuestions: totalQuestions ?? 0,
      totalAnswers: totalAnswers ?? 0,
      isYour: isYour ?? false,
      verify: verify ?? false,
      id: id ?? 0);
}

extension AnswerModelToListEntity on List<ProfileModel> {
  List<ProfileEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
