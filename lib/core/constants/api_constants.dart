// ignore_for_file: constant_identifier_names, unused_field
class BaseUrls {
  BaseUrls._();

  static const _LOCAL_BASE_URL = 'http://10.0.2.2:8080/';
  static const _DEV_BASE_URL = 'http://dev.eliezers.com/';
  static const _UAT_BASE_URL = 'http://...UAT.../';
  static const _PROD_BASE_URL = 'https://pro.eliezers.com/';
  static const String baseUrl = _LOCAL_BASE_URL;
}

// #### PATH ###

class ApiEndpoints {
  ApiEndpoints._();

  /// Home Endpoints
  static const question = '/api/question';
  static const getMySubject = '/api/subject/user';
  static const getQuestionBySubject = '/api/question/subject';
  static const likeQuestion = '/api/action';
  static const unLikeQuestion = '/api/action';
  static const postDeviceToken = '/api/firebasetoken';

  /// Category Endpoints
  static const GetCategoryEvent = '/api/category';
  static const createCategory = '/api/category';
  static const mergeCategroy = '/api/category/merge';
  static const deleteCategory = '/api/category/delete';
  static const editCategory = '/api/category/update';
  static const reorderCategory = '/api/category/reorder';

  static const getQuesitonInCategory = '/api/category/save';
  static const saveQuestiontoCateogry = '/api/category/save';
  static const deleteSaveQuestion = '/api/category/deleteQuestion';

  // Post Question Endpoints
  static const createQuestion = '/api/question';
  static const getTags = '/api/tags/search';
  static const createTag = '/api/tags';

  // OwnProfile Endpoints
  static const getProfile = '/api/me';
  static const findProfile = '/api/user/find';
  static const getQuestionByUser = '/api/question/user';
  static const getAnswerByUser = '/api/answer/user';
  static const getTopTag = '/api/tags/top-tag';

  // Search Endpoints
  static const getpopularSearch = '/api/popular-search';
  static const getSearchQuestion = '/api/question/search';
  static const getSearchUser = '/api/user/search';
  static const getSearchtAnswer = '/api/answer/search';

  // QuestionDetail Endpoints
  static const getAnswerInQuestion = '/api/answer';
  static const getCommnetInQuestion = '/api/comment';
  static const getCommentInAnswer = '/api/comment';
  static const updateQuestion = '/api/question';
  static const getTagCount = "/api/tags/search-count";
  static const getquestionbyTag = "/api/question/tag";

  static const answer = '/api/answer';
  static const createComment = '/api/comment';
  static const deleteComment = "/api/comment";
  static const updateComment = "/api/comment";

  static const likeComment = '/api/action';
  static const likeAnswer = '/api/action';
  static const correctAnswer = '/api/answer/edit_correct';

  // splash page Endpoints
  static const getSlogan = '/api/slogan';

  // setting Endpints
  static const getSetting = '/api/setting';
  static const getOtherSetting = '/api/setting/other';

  static const updateSetting = '/api/setting/update';

  // create account Endpoints
  static const register = '/register';
  static const getAllSubject = '/api/subject';
  static const updateUserSubject = '/api/user/update-user-subject';

  // feedback
  static const submitFeedback = '/api/feedback';

  //report Endpoints
  static const createReport = '/api/report';
  static const getReportType = '/api/report-type';
  static const getReportTypeDetail = '/api/report-type-detail';

  // personal info Endpoints
  static const updatePersonalInfo = '/api/user/update';
  static const checkEmail = '/api/user/check-email';
  static const checkUserName = '/api/user/check-userName';
  static const sendOtp = '/api/sendOtp';
  static const verifyOtp = '/api/verifyOtp';

  // Other Profile
  static const getOtherProfile = '/api/me';
  static const getOtherQuestionByUser = '/api/question/user';
  static const getOtherAnswerByUser = '/api/answer/other/user';

  // Auth
  static const login = '/api/login';
  static const logout = "/api/logout";
  static const createNewPassword = '/api/forgetPassword';
  static const checkUser = '/api/checkUser';
  static const authWithGoogle = '/api/loginAndRegister';
  static const user = '/api/user';

  // Security Login
  static const block = '/api/block';
  static const unBlock = '/api/block';
  static const createBlock = '/api/block';
  static const unHide = '/api/hide';
  static const unHideByQuestionId = '/api/hide/by-question';
  static const activeSession = '/api/active-session';
  static const deleteOtherSession = '/api/active-session/other';

  static const hide = '/api/hide';
  static const createhide = '/api/hide';
  static const changePassword = "/api/user/changePassword";
  // select avatar
  static const getAvatar = '/api/avatar';

  // data tag
  static const getOtherAnswerByTag = "/api/answer/other/tag";
  static const getOtherQuestionByTag = "/api/question/other/tag";
  static const getOwnAnswerByTag = "/api/answer/tag";
  static const getOwnQuestionByTag = "/api/question/tag";

  // notification
  static const notification = "/api/notification";
  // band
  static const band = "/api/bands";
  static const getQuestionInband = "/api/question/band";
  static const searchband = "/api/band/search";
  static const getbandinUser = "/api/band/user";
  static const joinband = "/api/band-member/join";
  static const requestToJoinband = "/api/band-member/request";
  static const approveUserInband = "/api/band-member/approve";
  static const rejectUserInband = "/api/band-member/reject";
  static const leaveband = "/api/band-member/leave";
  static const removeMemberband = "/api/band-member/remove";
  static const getOwnPermissionInband = "/api/band-permission";
  static const updatebandRole = "/api/band-role";
  static const bandPermission = "/api/band-permission";
  static const bandMember = "/api/band-member";

  ////
  static const events = "/api/events";
  static const booking = "/api/bookings";

  // musics

  static const musics = "/api/musics";

  static const favoriteMusics = "/api/favorites/musics";
  static const deletefavoriteMusics = "/api/favorites/musics/";
}
