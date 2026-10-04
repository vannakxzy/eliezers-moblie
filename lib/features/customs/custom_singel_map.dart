// ignore_for_file: prefer_collection_literals

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleGoogleMap extends StatefulWidget {
  final double lat;
  final double long;

  const SimpleGoogleMap({super.key, required this.lat, required this.long});

  @override
  State<SimpleGoogleMap> createState() => SimpleGoogleMapState();
}

class SimpleGoogleMapState extends State<SimpleGoogleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.long),
      zoom: 14.4746,
    );
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 200,
          child: AbsorbPointer(
            absorbing: true,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              markers: {
                if (widget.lat != 0)
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
        ),
      ],
    );
  }
}
