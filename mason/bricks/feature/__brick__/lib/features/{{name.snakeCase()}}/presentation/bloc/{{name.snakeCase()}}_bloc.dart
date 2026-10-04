import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';

part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_bloc.freezed.dart';

@Injectable()
class {{name.pascalCase()}}Bloc extends BaseBloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc() : super(const _Initial()) {
    on<InitPage>(_initPage);
  }

  FutureOr<void> _initPage(InitPage event, Emitter<{{name.pascalCase()}}State> emit) async {
    // TODO: implement InitPage logic
  }
}
