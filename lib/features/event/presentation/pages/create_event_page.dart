import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/size_constant.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../customs/map_detail.dart';
import '../bloc/create_event/bloc/create_event_bloc.dart';
import 'select_music_page.dart';

@RoutePage()
class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState
    extends BasePageBlocState<CreateEventPage, CreateEventBloc> {
  GoogleMapController? _mapcontroller;
  final now = DateTime.now();
  @override
  void initState() {
    super.initState();
    bloc.add(InitPage());
    // await controller.animateCamera(
    //   CameraUpdate.newLatLng(
    //     LatLng(
    //       state.lat,s
    //       state.long,
    //     ),
    //   ),
    // );
  }

  @override
  Widget buildPage(BuildContext context) {
    CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(11.61531, 102.98380),
      zoom: 14.4746,
    );

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(kRadius),
      borderSide: BorderSide(
        color: context.moonColors!.beerus,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
      ),

      // Listen for latitude / longitude changes
      body: BlocBuilder<CreateEventBloc, CreateEventState>(
        builder: (context, state) {
          return Padding(
            padding: kScreenPadding,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // =========================
                        // TITLE
                        // =========================
                        TextFormField(
                          maxLines: 20,
                          minLines: 3,
                          style: context.moonTypography!.body.text14.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: inputBorder,
                            enabledBorder: inputBorder,
                            isDense: true,
                            hintText: t.common.title,
                            hintStyle:
                                context.moonTypography!.body.text16.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            bloc.add(
                              TitleChange(value),
                            );
                          },
                        ),

                        const Gap(20),

                        // =========================
                        // DESCRIPTION
                        // =========================
                        TextFormField(
                          maxLines: 20,
                          minLines: 6,
                          style: context.moonTypography!.body.text14.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: inputBorder,
                            enabledBorder: inputBorder,
                            isDense: true,
                            hintText: t.common.description,
                            hintStyle:
                                context.moonTypography!.body.text16.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            bloc.add(
                              DescriptionChanged(value),
                            );
                          },
                        ),

                        const Gap(kPadding2),
                        TextFormField(
                          maxLines: 20,
                          minLines: 3,
                          style: context.moonTypography!.body.text14.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: inputBorder,
                            enabledBorder: inputBorder,
                            isDense: true,
                            hintText: t.event.promptDateTime,
                            hintStyle:
                                context.moonTypography!.body.text16.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            bloc.add(
                              DescriptionChanged(value),
                            );
                          },
                        ),

                        Gap(kPadding),
                        Text(t.event.startFrom,
                            style: context.moonTypography!.body.text14),
                        Gap(kPadding / 2),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: now,
                                    firstDate:
                                        DateTime(now.year, now.month, now.day),
                                    lastDate: DateTime(2100),
                                  );
                                  if (selectedDate != null) {
                                    bloc.add(GetStartDate(selectedDate));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding2,
                                    vertical: kPadding2,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: context.moonColors!.beerus),
                                    borderRadius:
                                        BorderRadius.circular(kRadius),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          size: 18),
                                      Gap(10),
                                      Text(
                                        state.startDate == null
                                            ? t.event.selectDate
                                            : '${state.startDate!.day}/'
                                                '${state.startDate!.month}/'
                                                '${state.startDate!.year}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () async {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  bloc.add(GetStartTime(selectedTime!));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(kPadding2),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: context.moonColors!.beerus),
                                      borderRadius:
                                          BorderRadius.circular(kRadius)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.access_time, size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        state.startTime == null
                                            ? t.event.selectTime
                                            : state.startTime!.format(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(kPadding2),
                        Text(t.event.endDate,
                            style: context.moonTypography!.body.text14),
                        Gap(kPadding / 2),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: now,
                                    firstDate:
                                        DateTime(now.year, now.month, now.day),
                                    lastDate: DateTime(2100),
                                  );
                                  if (selectedDate != null) {
                                    bloc.add(GetEndDate(selectedDate));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding2,
                                    vertical: kPadding2,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: context.moonColors!.beerus),
                                    borderRadius:
                                        BorderRadius.circular(kRadius),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          size: 18),
                                      Gap(10),
                                      Text(
                                        state.endDate == null
                                            ? t.event.selectDate
                                            : '${state.endDate!.day}/'
                                                '${state.endDate!.month}/'
                                                '${state.endDate!.year}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () async {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  bloc.add(GetEndTime(selectedTime!));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(kPadding2),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: context.moonColors!.beerus),
                                      borderRadius:
                                          BorderRadius.circular(kRadius)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.access_time, size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        state.endTime == null
                                            ? t.event.selectTime
                                            : state.endTime!.format(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(kPadding2),
                        MoonTextButton(
                          onTap: () async {
                            await showMoonModalBottomSheet(
                              height: MediaQuery.of(context).size.height * 0.8,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return SelectMusicPage();
                              },
                            );
                          },
                          label: Text("Music"),
                        ),

                        Gap(kPadding2),
                        const Text("Cover Image"),
                        const Gap(kPadding),
                        MoonButton.icon(
                          onTap: () async {
                            bloc.add(SelectCoverImage());
                            // await
                            // bloc.add(SelectCoverImage());
                          },
                          icon: const Icon(Icons.image),
                        ),
                        if (state.image.isNotEmpty)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.image.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              return Image.file(
                                state.image[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        Text(
                          state.location,
                          style: context.moonTypography!.body.text14.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Gap(20),
                        InkWell(
                          onTap: () async {
                            final LatLng? location =
                                await showMoonModalBottomSheet<LatLng>(
                              height: MediaQuery.of(context).size.height * 0.8,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return MapDetail(
                                  lat: state.lat,
                                  long: state.long,
                                  title: 'Select Location',
                                  isSeletcLocation: true,
                                );
                              },
                            );
                            bloc.add(
                              GetLatLngFromMap(
                                location!.latitude,
                                location.longitude,
                              ),
                            );
                            await _mapcontroller?.animateCamera(
                              CameraUpdate.newLatLng(
                                LatLng(
                                  location.latitude,
                                  location.longitude,
                                ),
                              ),
                            );
                          },
                          child: Container(
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
                                  _mapcontroller = controller;
                                },
                                zoomControlsEnabled: false,
                                myLocationEnabled: true,
                                mapToolbarEnabled: false,
                                myLocationButtonEnabled: false,
                                markers: {
                                  if (state.lat != 0)
                                    Marker(
                                      markerId: const MarkerId(
                                        "userLocation",
                                      ),
                                      position: LatLng(
                                        state.lat,
                                        state.long,
                                      ),
                                      infoWindow: const InfoWindow(
                                        title: "Selected Location",
                                      ),
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueRose,
                                      ),
                                    ),
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButtom(
                  isFullWidth: true,
                  onTap: () {
                    bloc.add(ClickCreateEvent());
                  },
                  // i: state.isloading,
                  title: t.common.create,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
