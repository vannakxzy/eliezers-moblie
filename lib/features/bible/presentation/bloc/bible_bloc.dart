import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';

part 'bible_event.dart';
part 'bible_state.dart';
part 'bible_bloc.freezed.dart';

@Injectable()
class BibleBloc extends BaseBloc<BibleEvent, BibleState> {
  BibleBloc() : super(const _Initial()) {
    on<InitPage>(_initPage);
  }

  FutureOr<void> _initPage(InitPage event, Emitter<BibleState> emit) async {
    // TODO: implement InitPage logic
  }
}
