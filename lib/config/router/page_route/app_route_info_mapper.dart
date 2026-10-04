import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../../features/band/domain/entities/band_entity.dart';
import '../../../features/home/domain/entities/question_entity.dart';
import '../../../features/musics/domain/entities/musics_entity.dart';
import '../app_router.gr.dart';
import 'app_route_info.dart';

abstract class BaseRouteInfoMapper {
  PageRouteInfo map(AppRouteInfo appRouteInfo);

  List<PageRouteInfo> mapList(List<AppRouteInfo> listAppRouteInfo) {
    return listAppRouteInfo.map(map).toList(growable: false);
  }
}

@LazySingleton(as: BaseRouteInfoMapper)
class AppRouteInfoMapper extends BaseRouteInfoMapper {
  @override
  PageRouteInfo map(AppRouteInfo appRouteInfo) {
    return appRouteInfo.when(
      createMusic: () => CreateMusicRoute(),
      testHome: () => TesthomeRoute(),
      eventDetial: (event) => EventDetailRoute(event: event),
      editDiscussion: (question) => EditDiscussionRoute(question: question),
      bandMember: (band) => BandMemberRoute(band: band),
      createband: () => CreatebandRoute(),
      bandDetail: (band, bandId) => BandDetailRoute(band: band, bandId: bandId),
      commentInDiscussion: (id, answer, notiCommentId, bandId) =>
          CommentInDiscussionRoute(
              bandId: bandId,
              id: id,
              answer: answer,
              notificationcommentId: notiCommentId),
      postDiscussion: (band) => PostDiscussionRoute(band: band),
      createEvent: () => CreateEventRoute(),
      discussionDetail: (questionEntity, answerId) =>
          DiscussionDetailRoute(answerId: answerId, discussion: questionEntity),
      users: () => UsersRoute(),
      discussion: () => DiscussionsRoute(),
      verifyLogin: (email, password) =>
          VerifyOtpLoginRoute(email: email, password: password),
      verifyOtpChangePassword: (password) =>
          VerifyotpChangePasswordRoute(password: password),
      resetPassword: (email, otp) => ResetPasswordRoute(email: email, otp: otp),
      activeSession: () => const ActiveSessionRoute(),
      questionTag: (tag) => QuestionTagRoute(tag: tag),
      appearance: () => const AppearanceRoute(),
      verifyOtpForgotpassword: (email) =>
          VerifyOtpForgotpasswordRoute(email: email),
      verifyEmailCreateAccount: (email, name, password) =>
          VerifyEmailCreateaccountRoute(
              email: email, name: name, password: password),
      privacyData: () => const PrivacyDataRoute(),
      walkThrough: () => const WalkthroughRoute(),
      settingNotification: () => const SettingNotificationRoute(),
      createNewPassword: (email) => CreateNewPasswordRoute(email: email),
      resultSearch: (text, tabIndex) =>
          ResultSearchRoute(text: text, tabIndex: tabIndex),
      home: () => ScaffoldWithNavBarRoute(),
      createCategory: (questionId) =>
          CreateCategoryRoute(questionId: questionId),
      setting: () => const SettingRoute(),
      login: () => const LoginRoute(),
      forgotPassword: () => const ForgotPasswordRoute(),
      categoryDetail: (index, mybloc) =>
          CategoryDetailRoute(index: index, myBloc: mybloc),
      notification: () => const NotificationRoute(),
      search: () => const SearchRoute(),
      securityAndLogin: () => const SecurityLoginRoute(),
      questionDetail: (id, questionEntity, answerId, commentId) {
        return QuestionDetailRoute(
          question: questionEntity,
          answerId: answerId,
          questionId: id,
        );
      },
      splash: () => const SplashRoute(),
      createAccount: () => const CreateAccountRoute(),
      selectSubject: () => const SeletctSubjectRoute(),
      feedback: () => const FeedbackRoute(),
      hide: () => const HideRoute(),
      allQuestion: (userId) => ALlQuestionRoute(userId: userId),
      allAnswer: (userId) => AllAnswerRoute(userId: userId),
      personalInfo: () => const PersonalInfoRoute(),
      block: () => const BlockRoute(),
      securityLogin: () => const SecurityLoginRoute(),
      otherProfile: (int userId) => ProfileRoute(userId: userId),
      changePassword: () => const ChangePasswordRoute(),
      createNewPost: (band) => PostQuestionRoute(band: band),
      answer: (questionId) => AnswerRoute(id: questionId),
      selectAvatar: () => const SelectAvatarRoute(),
      updateAvatar: () => const UpdateAvatarRoute(),
      commentInAnswer: (answerId, answer, notiCommentId, bandId) =>
          CommentInAnswerRoute(
              bandId: bandId,
              id: answerId,
              answer: answer,
              notificationcommentId: notiCommentId),
      commentInQuestion: (questionId) => CommentInQuestionRoute(id: questionId),
      dataTag: (index, userId, tag) =>
          DataTagRoute(tag: tag, userId: userId, index: index),
      createUserInfo: (String email, String otp) =>
          CreateUserInfoRoute(email: email, otp: otp),
      band: () => BandRoute(),
      searchband: () => SearchbandRoute(),
      resultSearchband: (value) => ResultSearchbandRoute(value: value),
      manageband: (BandEntity band) => ManagebandRoute(band: band),
      bandInfo: (BandEntity band) => BandInfoRoute(band: band),
      bandPermission: (BandEntity band) => BandPermissionnRoute(band: band),
      addbandMember: (BandEntity band) => AddbandMemberRoute(band: band),
      editQuestion: (QuestionEntity question) =>
          EditQuestionRoute(question: question),
      musicsDetail: (MusicsEntity entity) => MusicsDetailRoute(entity: entity),
      selectMusic: () => SelectAvatarRoute(),
    );
  }
}
