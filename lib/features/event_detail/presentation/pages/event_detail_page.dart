import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../core/utils/widgets/customer_dot.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../apps/page/display_image_page.dart';
import '../../../event/domain/entities/event_entity.dart';
import '../../../musics/domain/entities/musics_entity.dart';
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
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
                                      imageUrl: state.event.covers[0],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        widget.event.covers[0],
                                      ),
                                      alignment: AlignmentGeometry.topStart),
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).padding.top + 8,
                              left: kPadding,
                              child: CircleAvatar(
                                backgroundColor: Colors.black38,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).padding.top + 8,
                              right: kPadding,
                              child: CircleAvatar(
                                backgroundColor: Colors.black38,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.more_horiz_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    await showMoonModalBottomSheet(
                                      context: context,
                                      enableDrag: true,
                                      builder: (BuildContext context) =>
                                          Padding(
                                        padding: EdgeInsets.all(kPadding2),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomerDot(),
                                            kPadding.gap,
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kRadius2),
                                                color:
                                                    context.moonColors!.gohan,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  MoonButton(
                                                    buttonSize:
                                                        MoonButtonSize.lg,
                                                    onTap: () {},
                                                    leading: Icon(MoonIcons
                                                        .generic_edit_24_regular),
                                                    label: Text(t.common.edit),
                                                  ),
                                                  MoonButton(
                                                    buttonSize:
                                                        MoonButtonSize.lg,
                                                    onTap: () {
                                                      bloc.add(ClickDeleteEvent(
                                                          state.event.id));
                                                    },
                                                    leading: Icon(MoonIcons
                                                        .generic_delete_24_regular),
                                                    label:
                                                        Text(t.common.delete),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            kPadding.gap,
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(kPadding2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.event.title,
                                style: context.moonTypography!.heading.text24,
                              ),
                              Text(
                                state.event.description,
                                style: context.moonTypography!.body.text14,
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
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.moonTypography!.body.text14
                                          .copyWith(
                                            
                                              color:
                                                  context.moonColors!.trunks),
                                    ),
                                  ),
                                  kPadding.gap,
                                  InkWell(
                                    onTap: () {
                                      openGoogleMap(
                                          lat: state.event.latitude,
                                          lng: state.event.longitude);
                                    },
                                    child: Text(
                                      "Direction",
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
                                    state.event.startTime,
                                    style: context.moonTypography!.body.text14
                                        .copyWith(
                                            color: context.moonColors!.trunks),
                                  ),
                                  Gap(kPadding),
                                  const Icon(
                                    MoonIcons.time_calendar_success_24_regular,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    state.event.startTime,
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
                          padding: const EdgeInsets.all(kPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.event.agenda,
                                style: context.moonTypography!.heading.text20,
                              ),
                              kPadding.gap,
                              SizedBox(
                                height: 100,
                                child: PageView.builder(
                                  itemCount: state.event.covers.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      widget.event.covers[0],
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.event.musics.length,
                                itemBuilder: (context, index) {
                                  final MusicsEntity musice =
                                      state.event.musics[index];
                                  return MoonMenuItem(
                                    onTap: () {
                                      appRoute.push(
                                          AppRouteInfo.musicsDetail(musice));
                                    },
                                    // absorbGestures: true,
                                    leading: MoonAvatar(
                                      borderRadius: BorderRadius.circular(88),
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              musice.cover),
                                      backgroundColor:
                                          context.moonColors!.piccolo,
                                    ),
                                    label: Text(musice.title),
                                    content: Text(musice.artist),
                                    trailing: MoonButton.icon(
                                      onTap: () {
                                        bloc.add(ClickPlaySong(index));
                                        debugPrint("ddd");
                                      },
                                      icon: musice.isPlay
                                          ? Icon(
                                              MoonIcons.media_pause_24_regular,
                                            )
                                          : Icon(
                                              MoonIcons.media_play_24_regular,
                                            ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  maintainBottomViewPadding: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding2),
                    child: !state.event.isjoin
                        ? CustomButtom(
                            onTap: () {
                              bloc.add(ClickJoin(state.event.id));
                            },
                            isFullWidth: true,
                            title: t.event.join,
                          )
                        : CustomButtom(
                            outline: true,
                            colors: context.moonColors!.beerus,
                            onTap: () {
                              // debugPrint("")
                              bloc.add(ClickLeave(state.event.id));
                            },
                            isFullWidth: true,
                            title: t.event.leave,
                          ),
                  ),
                ),
                Gap(kPadding)
              ],
            ),
          ),
        );
      },
    );
  }
}
