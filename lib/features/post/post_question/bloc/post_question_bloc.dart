import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/bloc.dart';

part 'post_question_bloc.freezed.dart';
part 'post_question_event.dart';
part 'post_question_state.dart';

@Injectable()
class PostQuestionBloc extends BaseBloc<PostQuestionEvent, PostQuestionState> {
  PostQuestionBloc() : super(const PostQuestionState()) {
    on<PostQuestionEvent>((event, emit) {});
  }
}
