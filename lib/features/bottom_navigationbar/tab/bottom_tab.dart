import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../config/router/app_router.gr.dart';

enum BottomTab {
  events(
    icon: MoonIcons.time_calendar_success_24_regular,
    activeIcon: MoonIcons.time_calendar_success_24_regular,
    title: 'event',
  ),
  band(
    icon: MoonIcons.time_calendar_success_24_regular,
    activeIcon: MoonIcons.generic_home_24_regular,
    title: 'band',
  ),
  song(
    icon: MoonIcons.media_music_24_regular,
    activeIcon: MoonIcons.media_music_24_regular,
    title: 'song',
  ),

  favorite(
    icon: MoonIcons.generic_heart_24_regular,
    activeIcon: MoonIcons.generic_heart_24_regular,
    title: 'favorite',
  ),

  profile(
    icon: MoonIcons.generic_user_24_regular,
    activeIcon: MoonIcons.generic_user_24_regular,
    title: 'Profile',
  );

  const BottomTab({
    required this.icon,
    required this.title,
    required this.activeIcon,
    // this.isRoute = true,
  });

  final IconData icon;
  final IconData activeIcon;
  final String title;

  PageRouteInfo get route {
    switch (this) {
      case band:
        return const BandRoute();
      case favorite:
        return FavoriteRoute();
      case events:
        return const EventRoute();
      case BottomTab.song:
        return MusicsRoute();
      case profile:
        return ProfileRoute(userId: 0);
    }
  }
}
