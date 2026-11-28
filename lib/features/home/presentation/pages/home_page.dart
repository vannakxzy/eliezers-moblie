import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageBlocState<HomePage, HomeBloc> {
  
  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold();
  }
}
