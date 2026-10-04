import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';

part 'users_event.dart';
part 'users_state.dart';
part 'users_bloc.freezed.dart';

@Injectable()
class UsersBloc extends BaseBloc<UsersEvent, UsersState> {
  UsersBloc() : super(const _Initial()) {
    // on<UsersEvent>(_onUsersEvent);
  }
}
