import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';


import '../bloc/{{name.snakeCase()}}_bloc.dart';

@RoutePage()
class {{name.pascalCase()}}Page extends StatefulWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  State<{{name.pascalCase()}}Page> createState() => _{{name.pascalCase()}}PageState();
}

class _{{name.pascalCase()}}PageState
    extends BasePageBlocState<{{name.pascalCase()}}Page, {{name.pascalCase()}}Bloc> {

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold();
  }
}
