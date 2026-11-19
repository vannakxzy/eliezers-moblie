import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../notification/domain/entities/user_entity.dart';
import '../../domain/entities/event_entity.dart';

class EventWidget extends StatefulWidget {
  final EventEntity event;
  final VoidCallback onTap;
  final VoidCallback onTapJoin;
  final VoidCallback onTapSave;
  const EventWidget({
    super.key,
    required this.onTap,
    required this.event,
    required this.onTapSave,

    required this.onTapJoin,
  });

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(widget.event.startTime);
    final month = DateFormat('MMM').format(date); // Oct
    final day = DateFormat('dd').format(date);
    final moonColors = context.moonColors!;
    final moonTypography = context.moonTypography!;
    return InkWell(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kPadding),

        child: Container(
          color: context.moonColors!.beerus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event cover
              Stack(
                children: [
                  if (widget.event.covers.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: widget.event.covers[0],
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      placeholder: (context, url) => Container(
                          height: MediaQuery.sizeOf(context).height / 4,
                          alignment: Alignment.center,
                          child: Icon(MoonIcons.media_music_24_regular)),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.transparent,
                      ),
                    ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.12),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.18),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Glass date badge
                  Align(
                    alignment: AlignmentGeometry.bottomRight,
                    child: Container(
                      height: 44,
                      width: 44,
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: context.moonColors!.piccolo,
                        shape: BoxShape.circle,
                       
                      ),
                      child: Align(
                        alignment: AlignmentGeometry.bottomRight,
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: context.moonColors!.piccolo,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                day,
                                style: moonTypography.heading.text14.copyWith(
                                  color: Colors.white,
                                  height: 1,
                                ),
                              ),
                              Text(
                                month.toUpperCase(),
                                style: moonTypography.body.text10.copyWith(
                                  color: Colors.white,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Event information
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kPadding.gap,
                    Text(
                      widget.event.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: moonTypography.heading.text20.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Text(
                    //   widget.event.description,
                    //   maxLines: 1,
                    //   style: moonTypography.body.text16
                    //       .copyWith(color: context.moonColors!.trunks),
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MoonIcons.maps_marker_24_regular,
                          size: 20,
                          color: moonColors.trunks,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(widget.event.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: moonTypography.body.text12
                                  .copyWith(color: context.moonColors!.trunks)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildJoinedUsers(widget.event.joinedUser),
                    MoonButton.icon(
                      backgroundColor: widget.event.isSave
                          ? context.moonColors!.piccolo
                          : context.moonColors!.beerus,
                      borderRadius: BorderRadius.circular(888),
                      icon: Icon(MoonIcons.generic_heart_24_regular),
                      onTap: () {
                        widget.onTapSave();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget buildJoinedUsers(List<UserEntity> users) {
  const double circleSize = 30;
  const double overlap = 18;
  const int maxVisible = 3;

  final visibleUsers = users.take(maxVisible).toList();

  final remaining = users.length > maxVisible ? users.length - maxVisible : 0;

  return SizedBox(
    height: circleSize,
    width: visibleUsers.isEmpty
        ? 0
        : circleSize +
            (visibleUsers.length - 1) * (circleSize - overlap) +
            (remaining > 0 ? circleSize - overlap : 0),
    child: Stack(
      children: [
        // User avatars
        ...visibleUsers.asMap().entries.map((entry) {
          final index = entry.key;
          final user = entry.value;

          return Positioned(
            left: index * (circleSize - overlap),
            child: CircleAvatar(
              radius: circleSize / 2,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  user.avatar.isNotEmpty ? NetworkImage(user.avatar) : null,
              child: user.avatar.isEmpty
                  ? const Icon(Icons.person, size: 18)
                  : null,
            ),
          );
        }),

        // Remaining users count
        if (remaining > 0)
          Positioned(
            left: visibleUsers.length * (circleSize - overlap),
            child: CircleAvatar(
              radius: circleSize / 2,
              backgroundColor: Colors.grey.shade300,
              child: Text(
                '+$remaining',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
