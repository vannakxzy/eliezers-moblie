// ignore_for_file: prefer_collection_literals

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
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
  final Completer<maps.GoogleMapController> _controller =
      Completer<maps.GoogleMapController>();

  // Selected/current map location
  maps.LatLng location = const maps.LatLng(0, 0);

  // Google Places SDK
  late final FlutterGooglePlacesSdk places;

  @override
  void initState() {
    super.initState();
    location = maps.LatLng(
      widget.lat,
      widget.long,
    );
    places = FlutterGooglePlacesSdk(
      'AIzaSyD4b1bpXuW-4UlY4tt8MMgobrP77h50vNk',
    );
  }

  Future<void> searchPlace(String query) async {
    if (query.trim().isEmpty) {
      return;
    }
    try {
      final result = await places.findAutocompletePredictions(
        query,
      );
      debugPrint(
        'Predictions: ${result.predictions.length}',
      );

      for (final prediction in result.predictions) {
        debugPrint(
          'Place: ${prediction.primaryText}',
        );

        debugPrint(
          'Place ID: ${prediction.placeId}',
        );
      }
    } catch (e) {
      debugPrint(
        'Google Places error: $e',
      );
    }
  }

  /// Get selected place details
  Future<void> selectPlace(String placeId) async {
    try {
      final response = await places.fetchPlace(
        placeId,
        fields: [
          PlaceField.Address,
          PlaceField.Location,
          PlaceField.Name,
        ],
      );

      final place = response.place;

      if (place == null || place.latLng == null) {
        return;
      }

      final lat = place.latLng!.lat;
      final lng = place.latLng!.lng;

      final newLocation = maps.LatLng(
        lat,
        lng,
      );

      setState(() {
        location = newLocation;
      });

      final controller = await _controller.future;

      await controller.animateCamera(
        maps.CameraUpdate.newCameraPosition(
          maps.CameraPosition(
            target: newLocation,
            zoom: 15,
          ),
        ),
      );

      debugPrint('Selected place: ${place.name}');
      debugPrint('Address: ${place.address}');
      debugPrint('Latitude: $lat');
      debugPrint('Longitude: $lng');
    } catch (e) {
      debugPrint(
        'Get place details error: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Stack(
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
                      maps.GoogleMap(
                        mapType: maps.MapType.normal,
                        initialCameraPosition: maps.CameraPosition(
                          target: maps.LatLng(
                            widget.lat,
                            widget.long,
                          ),
                          zoom: 14.23,
                        ),
                        onMapCreated: (maps.GoogleMapController controller) {
                          if (!_controller.isCompleted) {
                            _controller.complete(controller);
                          }
                        },
                        onCameraMove: (maps.CameraPosition position) {
                          location = position.target;
                        },
                        zoomControlsEnabled: false,
                        myLocationEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationButtonEnabled: false,
                        markers: {
                          if (widget.isSeletcLocation == false)
                            maps.Marker(
                              markerId: const maps.MarkerId(
                                "userLocation",
                              ),
                              position: maps.LatLng(
                                widget.lat,
                                widget.long,
                              ),
                              infoWindow: const maps.InfoWindow(
                                title: "Current Location",
                              ),
                              icon: maps.BitmapDescriptor.defaultMarkerWithHue(
                                maps.BitmapDescriptor.hueRose,
                              ),
                            ),
                        },
                      ),

                      // ---------------------------------------------------
                      // CENTER LOCATION PIN
                      // ---------------------------------------------------
                      if (widget.isSeletcLocation == true)
                        const IgnorePointer(
                          ignoring: true,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Icon(
                                Icons.location_on,
                                size: 40,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---------------------------------------------------------------
          // TOP + BOTTOM CONTROLS
          // ---------------------------------------------------------------
          Container(
            margin: const EdgeInsets.only(
              bottom: 10,
              top: 60,
              left: 20,
              right: 20,
            ),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),

                    // -----------------------------------------------------
                    // RETURN TO ORIGINAL LOCATION
                    // -----------------------------------------------------
                    GestureDetector(
                      onTap: () async {
                        final maps.GoogleMapController controller =
                            await _controller.future;

                        final originalLocation = maps.LatLng(
                          widget.lat,
                          widget.long,
                        );

                        setState(() {
                          location = originalLocation;
                        });

                        await controller.animateCamera(
                          maps.CameraUpdate.newCameraPosition(
                            maps.CameraPosition(
                              target: originalLocation,
                              zoom: 14.4746,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: context.moonColors!.piccolo,
                          ),
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

                // ---------------------------------------------------------
                // DROP BUTTON
                // ---------------------------------------------------------
                CustomButtom(
                  colors: context.moonColors!.piccolo,
                  title: widget.isSeletcLocation == false
                      ? "Get Directions"
                      : "Drop",
                  onTap: () {
                    if (widget.isSeletcLocation == false) {
                      // Get directions
                    } else {
                      // Return selected location
                    }

                    Navigator.pop(
                      context,
                      location,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
