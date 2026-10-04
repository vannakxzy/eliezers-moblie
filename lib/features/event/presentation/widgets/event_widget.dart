import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../domain/entities/event_entity.dart';

class EventCard extends StatelessWidget {
  EventEntity event;
  Function onTap;
  Function onTapJoin;
  EventCard(
      {super.key,
      required this.onTap,
      required this.event,
      required this.onTapJoin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: kPadding2),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.primaryColor)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          event.cover,
                        ),
                        alignment: AlignmentGeometry.topCenter),
                  ),
                ),
                Positioned(
                  top: kPadding,
                  right: kPadding,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding2, vertical: kPadding),
                    decoration: BoxDecoration(
                      color: context.moonColors!.beerus,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '11',
                          style: context.moonTypography!.heading.text20
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                        Text(
                          'Jun',
                          style: context.moonTypography!.body.text16
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kPadding2.gap,
                  Text(
                    event.title,
                    style: context.moonTypography!.heading.text20,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(MoonIcons.maps_marker_24_regular),
                      SizedBox(width: 4),
                      Text(
                        event.location,
                        style: context.moonTypography!.body.text14
                            .copyWith(color: context.moonColors!.trunks),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  event.price == 0
                      ? Text(
                          t.event.free,
                          style: context.moonTypography!.body.text12
                              .copyWith(color: context.moonColors!.trunks),
                        )
                      : Text(
                          '\$ ${event.price}',
                          style: context.moonTypography!.heading.text12
                              .copyWith(color: context.moonColors!.trunks),
                        ),
                  if (!event.isJoin)
                    CustomButtom(
                      title: t.event.join,
                      onTap: () {
                        onTapJoin();
                      },
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
