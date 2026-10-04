import 'package:injectable/injectable.dart';
import '../data_sources/remotes/home_api_service.dart';
import '../models/homes/question_respose_model.dart';
import '../models/question_model.dart';
import '../models/subject_model.dart';
import '../../features/home/domain/entities/question_entity.dart';
import '../../features/home/domain/entities/question_respose_entity.dart';
import '../../features/home/domain/entities/subject_entity.dart';

import '../../features/home/domain/repository/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._homeApiService);
  final HomeApiService _homeApiService;

  @override
  Future<List<SubjectEntity>> GetSubjectEvent() async {
    final subject = await _homeApiService.GetSubjectEvent();
    return subject.data.toListEntity();
  }

  @override
  Future<List<QuestionEntity>> getQuestionBySubject({required int id}) async {
    final questionsResponse = await _homeApiService.getQuestionBySubject(id);
    return questionsResponse.data.toListEntity();
  }

  @override
  Future<void> likeQuestion(int id) async {
    await _homeApiService.likeQuestion(id);
  }

  @override
  Future<void> postDeviceToken({required String deviceToken}) async {
    await _homeApiService
        .postDeviceToken(PostDeviceTokenInput(device_token: deviceToken));
  }

  @override
  Future<void> unLikeQuestion(int id) async {
    await _homeApiService.unLikeQuestion(id);
  }

  @override
  Future<QuestionResposeEntity> getAllQuestions(GetQuestionInput input) async {
    final questionsResponse = await _homeApiService.getAllHomeQuestion(input);
    return questionsResponse.toEntity();
  }

  @override
  Future<int> countResult(GetQuestionInput input) async {
    return await _homeApiService.countResult(input);
  }
}
