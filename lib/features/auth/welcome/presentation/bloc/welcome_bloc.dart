import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../app/base/bloc/bloc.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';
part 'welcome_bloc.freezed.dart';

class WelcomeBloc extends BaseBloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const _Initial()) {
    on<WelcomeEvent>((event, emit) {});
  }
}
