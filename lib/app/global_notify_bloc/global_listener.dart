import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/bloc/bloc.dart';
import 'global_notify/bloc/bloc.dart';

class GlobalBlocListener<T extends BaseState>
    extends BlocListener<GlobalNotifyBloc, GlobalNotifyState> {
  GlobalBlocListener({
    super.key,
    super.child,
    required BlocWidgetListener<T> onListen,
  }) : super(
          listener: (context, state) {
            final s = state.pick<T>();
            if (s != null) {
              onListen.call(context, s);
            }
          },
          listenWhen: (previous, current) =>
              previous.pick<T>() != current.pick<T>(),
        );
}
