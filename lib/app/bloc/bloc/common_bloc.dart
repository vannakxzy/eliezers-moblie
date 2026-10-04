import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../base/bloc/bloc.dart';

part 'common_bloc.freezed.dart';
part 'common_event.dart';
part 'common_state.dart';

@injectable
class CommonBloc extends BaseBloc<CommonEvent, CommonState> {
  CommonBloc() : super(CommonState()) {
    on<_AddException>(_onAddException);
  }

  FutureOr<void> _onAddException(
      _AddException event, Emitter<CommonState> emit) async {
    emit(state.copyWith(exception: event.exception));
  }
}
