import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/log/log_utils.dart';
import '../../../di/di.dart';
import '../../app_bloc/app_bloc.dart';
import '../../bloc/bloc/common_bloc.dart';
import '../../exception_handler/exception_handler.dart';
import '../bloc/base_bloc.dart';
import '../navigation/app_navigator.dart';

abstract class BasePageBlocState<T extends StatefulWidget, B extends BaseBloc>
    extends BasePageBlocStateDelegate<T, B> with LogMixin {}

abstract class BasePageBlocStateDelegate<T extends StatefulWidget,
    B extends BaseBloc> extends State<T> with AutomaticKeepAliveClientMixin {
  Widget buildPage(BuildContext context);

  /// Navigation
  late final IAppNavigator appRoute = getIt.get<IAppNavigator>();

  late final AppBloc appBloc = getIt.get<AppBloc>();

  late final bool globalBloc = false;

  late final commonBloc = getIt.get<CommonBloc>()
    ..appRoute = appRoute
    ..appBloc = appBloc;

  late final exceptionHandler = ExceptionHandler(navigator: appRoute);

  @override
  bool get wantKeepAlive => false;

  @override
  void dispose() {
    super.dispose();
    bloc.disposeGlobalBLoc();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        if (!globalBloc) BlocProvider(create: (_) => bloc),
        BlocProvider(create: (_) => commonBloc),
      ],
      child: BlocListener<CommonBloc, CommonState>(
        listenWhen: (previous, current) =>
            previous.exception != current.exception,
        listener: (_, state) {
          handleException(state.exception, null);
        },
        child: buildPage(context),
      ),
    );
  }

  dynamic get param1 => null;

  late final B bloc =
      (globalBloc ? BlocProvider.of<B>(context) : getIt.get<B>(param1: param1))
        ..appRoute = appRoute
        ..appBloc = appBloc
        ..commonBloc = commonBloc;

  void handleException(Exception? exception, String? commonMessage) {
    if (exception == null) return;

    exceptionHandler.handleException(
      exception,
      commonMessage,
    );
  }
}
