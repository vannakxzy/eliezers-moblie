// ignore_for_file: prefer_collection_literals

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moon_design/moon_design.dart';

import '../../core/utils/widgets/custom_buttom.dart';
import '../../gen/i18n/translations.g.dart';

class MapDetail extends StatefulWidget {
  final bool isSeletcLocation;
  final double lat;
  final double long;
  final String title;
  final Function? ontap;

  const MapDetail({
    super.key,
    required this.lat,
    required this.long,
    required this.title,
    this.ontap,
    this.isSeletcLocation = false,
  });

  @override
  State<MapDetail> createState() => MapDetailState();
}

class MapDetailState extends State<MapDetail> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng location = LatLng(0, 0);
  @override
  void initState() {
    location = LatLng(widget.lat, widget.long);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  t.common.location,
                  style: context.moonTypography!.body.text18,
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(widget.lat, widget.long), zoom: 14.23),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onCameraMove: (position) {
                        location = position.target;
                      },
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      mapToolbarEnabled: false,
                      myLocationButtonEnabled: false,
                      markers: {
                        if (widget.isSeletcLocation == false)
                          Marker(
                            markerId: const MarkerId("userLocation"),
                            position: LatLng(
                              widget.lat,
                              widget.long,
                            ),
                            infoWindow: const InfoWindow(
                              title: "Current Location",
                            ),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueRose),
                          ),
                      },
                    ),
                    if (widget.isSeletcLocation == true)
                      const IgnorePointer(
                        ignoring: true,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Icon(
                              Icons.location_on,
                              size: 40,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(bottom: 10, top: 60, left: 20, right: 20),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final GoogleMapController controller =
                          await _controller.future;
                      await controller.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(widget.lat, widget.long),
                        zoom: 14.4746,
                      )));
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.moonColors!.piccolo,
                        ),
                        // color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.pin_drop_rounded,
                        color: context.moonColors!.piccolo.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomButtom(
                colors: context.moonColors!.piccolo,
                // white: MediaQuery.sizeOf(context).width * 0.6,
                title: widget.isSeletcLocation == false
                    ? "Get Directions"
                    : "Drop",
                onTap: () {
                  if (widget.isSeletcLocation == false) {
                    // openGoogleMap(
                    //   lat: widget.lat,
                    //   lng: widget.long,
                    //   context: context,
                    //   title: widget.title,
                    // );
                  } else {
                    // widget.ontap!(CameraPosition(
                    //   target: LatLng(
                    //     lat,
                    //     lng,
                    //   ),
                    //   zoom: 14.4746,
                    // ));
                    // appRou.pop(lat, lng);
                  }
                  Navigator.pop(context, location);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
