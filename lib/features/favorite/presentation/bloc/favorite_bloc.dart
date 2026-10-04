import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';
part 'favorite_bloc.freezed.dart';

@Injectable()
class FavoriteBloc extends BaseBloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const _Initial()) {
    on<InitPage>(_initPage);
  }
  FutureOr<void> _initPage(InitPage event, Emitter<FavoriteState> emit) {}
}
