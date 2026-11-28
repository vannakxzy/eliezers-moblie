import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const _Initial()) {
    on<InitPage>(_initPage);
  }

  FutureOr<void> _initPage(InitPage event, Emitter<HomeState> emit) async {
    // TODO: implement InitPage logic
  }
}
