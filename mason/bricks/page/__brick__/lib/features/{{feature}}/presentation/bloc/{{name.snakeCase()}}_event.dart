part of '{{name.snakeCase()}}_bloc.dart';

@freezed
class {{name.pascalCase()}}Event extends BaseEvent with _${{name.pascalCase()}}Event {
  const factory {{name.pascalCase()}}Event.initial() = _Initial;
}
