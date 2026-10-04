import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../gen/i18n/translations.g.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../bloc/bloc/search_band_bloc.dart';

@RoutePage()
class SearchbandPage extends StatefulWidget {
  const SearchbandPage({super.key});

  @override
  State<SearchbandPage> createState() => _SearchbandPageState();
}

class _SearchbandPageState
    extends BasePageBlocState<SearchbandPage, SearchbandBloc> {
  @override
  void initState() {
    bloc.add(InitialEvent());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.band.title),
      ),
    );
  }
}
