import 'package:injectable/injectable.dart';
import '../data_sources/remotes/feedback_api_service.dart';

import '../../features/feedback/domain/repository/feedback_repository.dart';

@LazySingleton(as: FeedbackRepository)
class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackApiService _feedbackApiService;
  FeedbackRepositoryImpl(this._feedbackApiService);
  @override
  Future<void> submitFeedback({required String description}) async {
    return await _feedbackApiService.submitFeedback(description);
  }
}
