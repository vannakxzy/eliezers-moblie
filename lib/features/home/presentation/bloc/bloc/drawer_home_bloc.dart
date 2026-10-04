import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../app/base/bloc/base_event.dart';
import '../../../../../app/base/bloc/base_state.dart';
part 'drawer_home_event.dart';
part 'drawer_home_state.dart';
part 'drawer_home_bloc.freezed.dart';

@Injectable()
class DrawerHomeBloc extends BaseBloc<DrawerHomeEvent, DrawerHomeState> {
  DrawerHomeBloc() : super(_Initial()) {
    // on<ClickDiscussions>(_clickDiscussion);
  }
}
