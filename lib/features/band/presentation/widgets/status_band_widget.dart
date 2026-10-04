import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../domain/entities/band_entity.dart';

class StatusbandWidget extends StatelessWidget {
  final BandEntity band;
  final Function ontap;
  const StatusbandWidget({super.key, required this.band, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: kPadding),
          color: Colors.transparent,
          child: band.status != "active"
              ? band.status == "pendding"
                  ? MoonTag(
                      tagSize: MoonTagSize.sm,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: context.moonColors!.piccolo,
                      ),
                      label: Text(t.band.pendding,
                          style: context.moonTypography!.body.text14.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    )
                  : MoonTag(
                      tagSize: MoonTagSize.sm,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: context.moonColors!.piccolo,
                      ),
                      label: band.isPublic
                          ? Text(t.band.request,
                              style: context.moonTypography!.body.text14
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))
                          : Text(t.common.join,
                              style: context.moonTypography!.body.text14
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                    )
              : SizedBox.shrink()
          // : MoonTag(
          //     tagSize: MoonTagSize.sm,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: context.moonColors!.piccolo)),
          //     label: Text(
          //         band.isPublic ? t.common.requested : t.common.joined,
          //         style: context.moonTypography!.body.text14.copyWith(
          //             color: context.moonColors!.piccolo,
          //             fontWeight: FontWeight.w500)),
          //   ),
          ),
    );
  }
}
