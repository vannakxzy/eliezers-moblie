import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/bloc.dart';

part 'walkthrough_bloc.freezed.dart';

part 'walkthrough_event.dart';
part 'walkthrough_state.dart';

@Injectable()
class WalkthroughBloc extends BaseBloc<WalkthroughEvent, WalkthroughState> {
  WalkthroughBloc() : super(WalkthroughState());
}
