import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/category/presentation/bloc/category_bloc.dart';
import '../../../features/band/domain/entities/band_entity.dart';
import '../../../features/event/domain/entities/event_entity.dart';
import '../../../features/home/domain/entities/question_entity.dart';
import '../../../features/musics/domain/entities/musics_entity.dart';
import '../../../features/post/domain/entities/tag_entity.dart';
import '../../../features/profile/domain/entities/answer_entity.dart';

import '../../../features/profile/domain/entities/top_tag_entity.dart';

part 'app_route_info.freezed.dart';

@Freezed(when: FreezedWhenOptions(when: true))
class AppRouteInfo with _$AppRouteInfo {
  const factory AppRouteInfo.testHome() = _TestHome;
  const factory AppRouteInfo.eventDetial(EventEntity event) = _EventDetial;
  const factory AppRouteInfo.verifyLogin(String email, String password) =
      _VerifyLogin;
  const factory AppRouteInfo.walkThrough() = _WalkThrough;
  const factory AppRouteInfo.splash() = _Splash;
  const factory AppRouteInfo.home() = _BottomNavigationBar;
  const factory AppRouteInfo.notification() = _Notification;
  const factory AppRouteInfo.search() = _Search;
  const factory AppRouteInfo.createEvent() = _CreateEvent;
  const factory AppRouteInfo.setting() = _Setting;
  const factory AppRouteInfo.login() = _Login;
  const factory AppRouteInfo.selectMusic() = _SelectMusic;
  const factory AppRouteInfo.createUserInfo(String email, String otp) =
      _CreateUserInfo;
  const factory AppRouteInfo.editQuestion(QuestionEntity question) =
      _EditQuestion;
  const factory AppRouteInfo.editDiscussion(QuestionEntity question) =
      _EditDiscussion;
  const factory AppRouteInfo.forgotPassword() = _ForgotPassword;
  const factory AppRouteInfo.categoryDetail(
      {required int index, required CategoryBloc mybloc}) = _CategoryDetail;
  const factory AppRouteInfo.createCategory({required int questionId}) =
      _CreateCategory;
  const factory AppRouteInfo.securityAndLogin() = _SecurityAndLogin;
  const factory AppRouteInfo.resultSearch(String text, int tabIndex) =
      _ResultSearch;
  const factory AppRouteInfo.questionDetail(
      {required int id,
      QuestionEntity? questionEntity,
      int? answerId,
      int? commentId}) = _QuestionDetail;
  const factory AppRouteInfo.discussionDetail(
      {QuestionEntity? questionEntity, int? answerId}) = _DiscussionDetail;
  const factory AppRouteInfo.commentInDiscussion(
          int id, AnswertEntity answer, int notiCommentId, int bandId) =
      _CommentInDiscussion;
  const factory AppRouteInfo.createAccount() = _CreateAccount;
  const factory AppRouteInfo.selectSubject() = _SelectSubject;
  const factory AppRouteInfo.hide() = _Hide;
  const factory AppRouteInfo.feedback() = _Feedback;
  const factory AppRouteInfo.settingNotification() = _SettingNotification;
  const factory AppRouteInfo.allQuestion(int userId) = _AllQuestion;
  const factory AppRouteInfo.allAnswer(int userId) = _AllAnswer;
  const factory AppRouteInfo.personalInfo() = _PersonalInfo;
  const factory AppRouteInfo.block() = _Block;
  const factory AppRouteInfo.createMusic() = _CreateMusic;
  const factory AppRouteInfo.otherProfile({required int userId}) =
      _OtherProfile;
  const factory AppRouteInfo.securityLogin() = _SecurityLogin;
  const factory AppRouteInfo.createNewPassword({required String email}) =
      _CreateNewPassword;

  const factory AppRouteInfo.changePassword() = _ChangePassword;

  const factory AppRouteInfo.createNewPost(BandEntity band) = _CreateNewPost;
  const factory AppRouteInfo.postDiscussion(BandEntity band) = _PostDiscussion;
  const factory AppRouteInfo.commentInQuestion(int questionId) = _Comment;
  const factory AppRouteInfo.answer(int questionId) = _Answer;
  const factory AppRouteInfo.commentInAnswer(
          int answerId, AnswertEntity answer, int notiCommentId, int bandId) =
      _CommentInAnswer;
  const factory AppRouteInfo.selectAvatar() = _SelectAvatar;
  const factory AppRouteInfo.updateAvatar() = _UpdateAvatar;
  const factory AppRouteInfo.questionTag(TagEntity tag) = _QuestionTag;
  const factory AppRouteInfo.dataTag(
      {required int index,
      required int userId,
      required List<TopTagEntity> tag}) = _DataTag;
  const factory AppRouteInfo.privacyData() = _PrivacyData;
  const factory AppRouteInfo.verifyOtpForgotpassword({required String email}) =
      _VerifyOtpForgotpassword;
  const factory AppRouteInfo.verifyEmailCreateAccount(
      {required String email,
      required String name,
      required String password}) = _VerifyEmailCreateAccount;
  const factory AppRouteInfo.appearance() = _Appearance;
  const factory AppRouteInfo.discussion() = _Discussion;
  const factory AppRouteInfo.activeSession() = _ActiveSession;
  const factory AppRouteInfo.resetPassword(String email, String otp) =
      _ResetPassword;
  const factory AppRouteInfo.verifyOtpChangePassword(String password) =
      _VerifyOtpChangePassword;
  const factory AppRouteInfo.users() = _Users;
  const factory AppRouteInfo.band() = _band;
  const factory AppRouteInfo.searchband() = _Searchband;
  const factory AppRouteInfo.resultSearchband(String value) = _ResultSearchband;
  const factory AppRouteInfo.createband() = _Createband;
  const factory AppRouteInfo.bandDetail(BandEntity band, int bandId) =
      _bandDetail;
  const factory AppRouteInfo.manageband(BandEntity band) = _Manageband;
  const factory AppRouteInfo.bandInfo(BandEntity band) = _bandInfo;
  const factory AppRouteInfo.bandPermission(BandEntity band) = _bandPermission;
  const factory AppRouteInfo.addbandMember(BandEntity band) =
      _AddCommuntiyMember;
  const factory AppRouteInfo.bandMember(BandEntity band) = _bandMember;
  const factory AppRouteInfo.musicsDetail(MusicsEntity entity) = _MusicsDetail;
}
