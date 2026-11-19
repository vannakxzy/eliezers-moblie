import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_cache_image_cricle.dart';
import '../../../../core/utils/widgets/customer_dot.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../apps/page/display_image_page.dart';
import '../../../event/domain/entities/event_entity.dart';
import '../../../event/presentation/widgets/confirm_delete_event_alert.dart';
import '../../../event/presentation/widgets/event_widget.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../widgets/agenda_widget.dart';
import '../widgets/musice_list.dart';

@RoutePage()
class EventDetailPage extends StatefulWidget {
  final EventEntity event;

  const EventDetailPage({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState
    extends BasePageBlocState<EventDetailPage, EventDetailBloc> {

  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    bloc.add(InitPage(widget.event));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<EventDetailBloc, EventDetailState>(
      builder: (context, state) {
        final event = state.event;

        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // EVENT COVER
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (event.covers.isEmpty) return;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayImagePage(
                              isYourImage: true,
                              tag: "event-detail",
                              report: ReportInput(
                                user_id: event.userId,
                              ),
                              imageUrl: event.covers[0],
                            ),
                          ),
                        );
                      },
                      child: event.covers.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: event.covers[0],
                              width: double.infinity,
                              height: 350,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              placeholder: (context, url) => Container(
                                height: 350,
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 350,
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 40,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              height: 350,
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.image_not_supported_outlined,
                                size: 40,
                              ),
                            ),
                    ),

                    // BACK BUTTON
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

                    // MORE BUTTON
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
                              builder: (BuildContext context) => Padding(
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
                                            BorderRadius.circular(kRadius2),
                                        color: context.moonColors!.gohan,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MoonButton(
                                            buttonSize: MoonButtonSize.lg,
                                            onTap: () {},
                                            leading: Icon(
                                              MoonIcons.generic_edit_24_regular,
                                            ),
                                            label: Text(t.common.edit),
                                          ),
                                          MoonButton(
                                            buttonSize: MoonButtonSize.lg,
                                            onTap: () async {
                                              unFocus();

                                              final result =
                                                  await ConfirmDeleteEventAlert
                                                      .show(context,
                                                          widget.event.isown);

                                              if (result) {
                                                bloc.add(
                                                  ClickDeleteEvent(event.id),
                                                );
                                                appRoute.pop();
                                              }
                                            },
                                            leading: Icon(
                                              MoonIcons
                                                  .generic_delete_24_regular,
                                            ),
                                            label: Text(t.common.delete),
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

                    // JOIN / LEAVE BUTTON
                    Positioned(
                      bottom: kPadding,
                      left: kPadding2,
                      right: kPadding2,
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            buildJoinedUsers(event.joinedUser),
                            if (event.joinedUser.isNotEmpty) kPadding2.gap,
                            if (!event.isjoin)
                              MoonButton(
                                width: 120,
                                backgroundColor: context.moonColors!.piccolo,
                                borderRadius: BorderRadius.circular(kRadius),
                                onTap: () {
                                  bloc.add(ClickJoin(event.id));
                                },
                                label: Text(t.event.join),
                              )
                            else
                              MoonButton(
                                width: 120,
                                borderRadius: BorderRadius.circular(kRadius),
                                backgroundColor: AppColor.dangerColor,
                                onTap: () {
                                  bloc.add(ClickLeave(event.id));
                                },
                                label: Text(t.event.leave),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // EVENT INFORMATION
                Padding(
                  padding: EdgeInsets.all(kPadding2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: context.moonTypography!.heading.text18,
                      ),

                      if (event.description.isNotEmpty) ...[
                        kPadding.gap,
                        Text(
                          event.description,
                          style: context.moonTypography!.body.text14,
                        ),
                      ],

                      kPadding.gap,

                      // LOCATION
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
                              event.location,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  context.moonTypography!.body.text14.copyWith(
                                color: context.moonColors!.trunks,
                              ),
                            ),
                          ),
                          kPadding.gap,
                          InkWell(
                            onTap: () {
                              openGoogleMap(
                                lat: event.latitude,
                                lng: event.longitude,
                              );
                            },
                            child: Text(
                              "Direction",
                              style:
                                  context.moonTypography!.body.text14.copyWith(
                                color: context.moonColors!.piccolo,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),

                      kPadding.gap,

                      // EVENT TIME
                      Row(
                        children: [
                          const Icon(
                            MoonIcons.time_calendar_success_24_regular,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.startTime,
                              style:
                                  context.moonTypography!.body.text14.copyWith(
                                color: context.moonColors!.trunks,
                              ),
                            ),
                          ),
                          const Icon(
                            MoonIcons.time_calendar_success_24_regular,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.endTime,
                              style:
                                  context.moonTypography!.body.text14.copyWith(
                                color: context.moonColors!.trunks,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                AppDivider.medium(),

                // MUSIC AND AGENDA
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // MUSIC LIST
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: event.musics.length,
                        itemBuilder: (context, index) {
                          final music = event.musics[index];

                          return MusicListItem(
                            music: music,
                            isPlaying: music.isPlay,
                            onTap: () {
                              appRoute.push(
                                AppRouteInfo.musicsDetail(music),
                              );
                            },
                            onPlayTap: () async {
                              try {
                                bloc.add(ClickPlaySong(index));

                                if (music.isPlay) {
                                  await player.pause();
                                } else {
                                  await player.stop();
                                  await player.play(
                                    UrlSource(music.audio),
                                  );
                                }
                              } catch (e) {
                                debugPrint('Audio error: $e');
                              }
                            },
                          );
                        },
                      ),

                      // AGENDA TITLE
                      Text(
                        t.event.agenda,
                        style: context.moonTypography!.heading.text20,
                      ),

                      kPadding.gap,

                      // HORIZONTAL AGENDA
                      if (event.covers.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(
                              event.covers.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AgendaWidget(
                                            images: event.covers,
                                            initialIndex: index,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: 'agenda_image_$index',
                                      child: CustomCachedImageCircle(
                                        image: event.covers[index],
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                4,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
