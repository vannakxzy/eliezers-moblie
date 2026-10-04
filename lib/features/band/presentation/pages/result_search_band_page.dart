import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../gen/i18n/translations.g.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class ResultSearchbandPage extends StatefulWidget {
  final String value;
  const ResultSearchbandPage({super.key, required this.value});

  @override
  State<ResultSearchbandPage> createState() => _ResultSearchbandPageState();
}

class _ResultSearchbandPageState
    extends BasePageBlocState<ResultSearchbandPage, bandBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.band.title),
      ),
    );
  }
}
