import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';

part 'post_topic_bloc.freezed.dart';
part 'post_topic_event.dart';
part 'post_topic_state.dart';

@Injectable()
class PostTopicBloc extends BaseBloc<PostTopicEvent, PostTopicState> {
  PostTopicBloc() : super(const PostTopicState()) {
    on<PostTopicEvent>((event, emit) {});
  }
}
