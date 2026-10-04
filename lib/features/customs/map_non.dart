// ignore_for_file: prefer_collection_literals

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constants/app_colors_constants.dart';
import '../../core/utils/widgets/custom_buttom.dart';

class MapNon extends StatefulWidget {
  final double lat;
  final double long;
  final String title;
  const MapNon(
      {super.key, required this.lat, required this.long, required this.title});

  @override
  State<MapNon> createState() => MapNonState();
}

class MapNonState extends State<MapNon> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 50,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "close",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColor.secondnaryColor),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Lcation",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text(
                      "close",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.transparent),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.lat, widget.long), zoom: 14.23),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: {
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
                        target: LatLng(0, 0
                            // todoController.currentlat.value,
                            // todoController.currentlng.value,
                            ),
                        zoom: 14.4746,
                      )));
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.secondnaryColor,
                        ),
                        color: AppColor.secondnaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.pin_drop_rounded,
                        color: AppColor.secondnaryColor.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomButtom(
                colors: AppColor.secondnaryColor,
                // white: MediaQuery.sizeOf(context).width * 0.6,
                title: "Get Directions",
                onTap: () {
                  // openGoogleMap(
                  //   lat: widget.lat,
                  //   lng: widget.long,
                  //   context: context,
                  //   title: widget.title,
                  // );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
