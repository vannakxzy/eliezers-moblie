import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class BiblePage extends StatefulWidget {
  const BiblePage({super.key});

  @override
  State<BiblePage> createState() => _BiblePageState();
}

class _BiblePageState extends BasePageBlocState<BiblePage, BibleBloc> {
  
  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold();
  }
}
