import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../di/di.dart';
import '../../app_bloc/app_bloc.dart';
import '../../bloc/bloc/common_bloc.dart';
import '../../global_notify_bloc/global_notify/bloc/bloc.dart';
import '../navigation/app_navigator.dart';
import 'base_event.dart';
import 'base_state.dart';

//  Bloc<LoginEvent, LoginState>
abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends BaseBlocDeligate<E, S> {
  BaseBloc(super.initialState);
}

abstract class BaseBlocDeligate<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseBlocDeligate(super.initialState);

  late final IAppNavigator appRoute;
  late final AppBloc appBloc;
  late final CommonBloc _commonBloc;

  set commonBloc(CommonBloc commonBloc) {
    _commonBloc = commonBloc;
  }

  CommonBloc get commonBloc =>
      this is CommonBloc ? this as CommonBloc : _commonBloc;

  FutureOr<void> runAppCatching(
    Future<void> Function() action, {
    bool handleError = false,
    Future<void> Function(Exception error)? onError,
  }) async {
    try {
      await action.call();
    } on Exception catch (exception) {
      await onError?.call(exception);
      if (handleError) {
        await addException(exception);
      }
    }
  }

  void notifyGlobal<T extends BaseState>(T newState) {
    getIt.get<GlobalNotifyBloc>().add(NotifyState<T>(T, newState));
  }

  void disposeGlobalBLoc<T extends BaseState>() {
    // getIt.get<GlobalNotifyBloc>().add(DisposeState<T>(T));
  }

  Future<void> addException(Exception? exception) async {
    if (exception == null) return;
    commonBloc.add(CommonEvent.addException(exception));
  }
}
