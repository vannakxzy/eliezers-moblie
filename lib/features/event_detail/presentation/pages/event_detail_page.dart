import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../apps/page/display_image_page.dart';
import '../../../event/domain/entities/event_entity.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class EventDetailPage extends StatefulWidget {
  final EventEntity event;
  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState
    extends BasePageBlocState<EventDetailPage, EventDetailBloc> {
  @override
  void initState() {
    bloc.add(InitPage(widget.event));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<EventDetailBloc, EventDetailState>(
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DisplayImagePage(
                                      isYourImage: true,
                                      tag: "event-detail",
                                      report: ReportInput(
                                          user_id: state.event.userId),
                                      imageUrl: state.event.cover,
                                    ),
                                  ));
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      widget.event.cover,
                                    ),
                                    alignment: AlignmentGeometry.topStart),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: kPadding,
                            child: CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ),
                          // Positioned(
                          //   top: MediaQuery.of(context).padding.top + 8,
                          //   right: kPadding,
                          //   child: CircleAvatar(
                          //     backgroundColor: Colors.black54,
                          //     child: IconButton(
                          //       icon: Icon(
                          //         MoonIcons.generic_share_arrow_24_regular,
                          //         color: Colors.white,
                          //       ),
                          //       onPressed: () {
                          //         bloc.add(ClickShare());
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(kPadding2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.title,
                              style: context.moonTypography!.heading.text20,
                            ),
                            kPadding.gap,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  MoonIcons.maps_marker_24_regular,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    widget.event.location,
                                    style: context.moonTypography!.body.text14
                                        .copyWith(
                                            color: context.moonColors!.trunks),
                                  ),
                                ),
                                kPadding.gap,
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "direction",
                                    style: context.moonTypography!.body.text14
                                        .copyWith(
                                      color: Color(0xff126782),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            kPadding.gap,
                            Row(
                              children: [
                                const Icon(
                                  MoonIcons.time_calendar_success_24_regular,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '12/02/2024 6:00 AM',
                                  style: context.moonTypography!.body.text14
                                      .copyWith(
                                          color: context.moonColors!.trunks),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AppDivider.medium(),
                      Padding(
                        padding: const EdgeInsets.all(kPadding2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Event Detail",
                              style: context.moonTypography!.heading.text20,
                            ),
                            kPadding.gap,
                            Text(
                              "Eventfkadsjfkjdaslkfjlkadsjflkadsjflk\njadsfjdslkfjlsjflksdjfsdafksdjfkjsadkfj;aksfdj;adsjf;jkdsa;lfjlkdsfjsdjflkjlkdsfjlkajfsdlksajfdjlkdfjalkdsjflkjasdlkfjaskfdj;skdjf;ls Detail",
                              style: context.moonTypography!.body.text14,
                            ),
                            kPadding.gap,
                            Column(
                              children: [
                                ...List.generate(
                                  3,
                                  (index) {
                                    return InkWell(
                                      onTap: () {
                                        // appRoute.push(AppRouteInfo.musicsDetail(
                                        //     MusicsEntity()));
                                      },
                                      child: AnimatedContainer(
                                        margin: EdgeInsets.symmetric(
                                            vertical:
                                                state.playSongIndex == index
                                                    ? kPadding
                                                    : 0),
                                        duration: Duration(milliseconds: 300),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                          color: state.playSongIndex == index
                                              ? Colors.blue
                                              : Colors.transparent,
                                        )),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 0.5),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    "https://i.pinimg.com/1200x/1a/36/38/1a363833061dfd02024185e2d95f5070.jpg",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            kPadding.gap,
                                            Expanded(
                                              child: Text(
                                                "Khmer Sl Khmer",
                                                style: context.moonTypography!
                                                    .body.text14,
                                              ),
                                            ),
                                            kPadding.gap,
                                            IconButton(
                                                onPressed: () {
                                                  bloc.add(
                                                      ClickPlaySong(index));
                                                },
                                                icon: Icon(
                                                  MoonIcons.media_play_24_light,
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SafeArea(
                    maintainBottomViewPadding: true,
                    child: Padding(
                      padding: const EdgeInsets.all(kPadding2),
                      child: !state.event.isJoin
                          ? CustomButtom(
                              onTap: () {
                                bloc.add(ClickJoin(state.event.id));
                              },
                              isFullWidth: true,
                              title: t.event.join,
                            )
                          : MoonButton(
                              backgroundColor: context.moonColors!.beerus,
                              onTap: () {
                                bloc.add(ClickLeave(state.event.id));
                              },
                              isFullWidth: true,
                              label: Text(t.event.leave),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
