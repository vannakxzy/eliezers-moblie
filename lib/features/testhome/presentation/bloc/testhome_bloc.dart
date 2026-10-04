import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';

part 'testhome_event.dart';
part 'testhome_state.dart';
part 'testhome_bloc.freezed.dart';

@Injectable()
class TesthomeBloc extends BaseBloc<TesthomeEvent, TesthomeState> {
  TesthomeBloc() : super(const _Initial()) {
    on<SumX>(_sumX);
    on<InitPage>(_initPage);
  }

  FutureOr<void> _sumX(SumX event, Emitter<TesthomeState> emit) async {
    emit(state.copyWith(x: state.x + 1));
  }

  FutureOr<void> _initPage(InitPage event, Emitter<TesthomeState> emit) async {
    // TODO: implement InitPage logic
  }
}
