import 'package:injectable/injectable.dart';

import '../../features/{{name.snakeCase()}}/domain/repository/{{name.snakeCase()}}_repository.dart';

@LazySingleton(as: {{name.pascalCase()}}Repository)
class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository{
  
}