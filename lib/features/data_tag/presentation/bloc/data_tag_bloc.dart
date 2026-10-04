import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/bloc.dart';

part 'data_tag_bloc.freezed.dart';
part 'data_tag_event.dart';
part 'data_tag_state.dart';

@Injectable()
class DataTagBloc extends BaseBloc<DataTagEvent, DataTagState> {
  DataTagBloc() : super(const _Initial());
}
