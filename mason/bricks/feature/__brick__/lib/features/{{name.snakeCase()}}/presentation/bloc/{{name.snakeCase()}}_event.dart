part of '{{name.snakeCase()}}_bloc.dart';

class {{name.pascalCase()}}Event extends BaseEvent {}

@freezed
class InitPage extends {{name.pascalCase()}}Event with _$InitPage {
  const factory InitPage() = _InitPage;
}
