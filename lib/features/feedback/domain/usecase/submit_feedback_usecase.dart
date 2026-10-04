import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/feedback_repository.dart';

@Injectable()
class SubmitFeedbackUseCase extends BaseUseCase<String, void> {
  final FeedbackRepository _feedbackRepository;
  SubmitFeedbackUseCase(this._feedbackRepository);
  @override
  Future<void> excecute(String input) async {
    return await _feedbackRepository.submitFeedback(description: input);
  }
}
