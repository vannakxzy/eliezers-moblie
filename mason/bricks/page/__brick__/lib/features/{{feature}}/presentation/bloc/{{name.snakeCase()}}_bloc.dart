import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/bloc.dart';

part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_bloc.freezed.dart';

@Injectable()
class {{name.pascalCase()}}Bloc
    extends BaseBloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc() : super(const {{name.pascalCase()}}State()) {
    on<{{name.pascalCase()}}Event>(_on{{name.pascalCase()}}Event);
  }

  FutureOr<void> _on{{name.pascalCase()}}Event(
      {{name.pascalCase()}}Event event, Emitter<{{name.pascalCase()}}State> emit) async {
    await event.map(
      initial: (value) async {
        await _onInitial(event, emit);
      },
    );
  }

  FutureOr<void> _onInitial(
      {{name.pascalCase()}}Event event, Emitter<{{name.pascalCase()}}State> emit) async {
    await runAppCatching(() async {
     
    },
    onError: (error) async {},
     );
  }
}
