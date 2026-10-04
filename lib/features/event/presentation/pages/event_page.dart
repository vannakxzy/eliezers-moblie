import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../widgets/event_widget.dart';

@RoutePage()
class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends BasePageBlocState<EventPage, EventBloc> {
  @override
  void initState() {
    bloc.add(InitPage());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.event.title),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              appRoute.push(AppRouteInfo.createEvent());
            },
            icon: Icon(MoonIcons.generic_share_android_24_light,
                color: context.moonColors!.textPrimary),
          )
        ],
      ),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: state.isloading && state.events.isEmpty
                ? Center(
                    //  child: MoonC,
                    child: CircularProgressIndicator(),
                  )
                : state.events.isEmpty
                    ? const Center(child: SizedBox())
                    : AppSmartRefreshScrollView(
                        enableLoadMore: state.isMorePage,
                        onLoadMore: () async =>
                            bloc.add(Refreshpage(state.page)),
                        onRefresh: () async {
                          bloc.add(Refreshpage(1));
                        },
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final events = state.events[index];
                              return EventCard(
                                event: events,
                                onTap: () {
                                  appRoute
                                      .push(AppRouteInfo.eventDetial(events));
                                },
                                onTapJoin: () {
                                  debugPrint('Join event ${events.id}');
                                  bloc.add(ClickJoin(index));
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Gap(kPadding),
                            itemCount: state.events.length),
                      ),
          );
        },
      ),
    );
  }
}
