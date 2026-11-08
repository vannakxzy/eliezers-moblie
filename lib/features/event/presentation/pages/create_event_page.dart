import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/size_constant.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../customs/map_detail.dart';
import '../bloc/create_event/bloc/create_event_bloc.dart';
import 'select_music_part.dart';

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
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(kRadius),
      borderSide: BorderSide(
        color: context.moonColors!.piccolo,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("${t.common.create} ${t.event.title} "),
      ),

      // Listen for latitude / longitude changes
      body: SafeArea(
        child: BlocBuilder<CreateEventBloc, CreateEventState>(
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
                            controller: state.titleCon,
                            maxLines: 20,
                            minLines: 3,
                            style: context.moonTypography!.body.text14.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: focusedBorder,
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
                            controller: state.desCon,
                            minLines: 6,
                            style: context.moonTypography!.body.text14.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: focusedBorder,
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
                          Gap(kPadding),
                          Text(t.event.startFrom,
                              style: context.moonTypography!.body.text14),
                          Gap(kPadding / 2),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () async {
                                    unFocus();
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: now,
                                      firstDate: DateTime(
                                          now.year, now.month, now.day),
                                      lastDate: DateTime(2100),
                                    );
                                    if (selectedDate != null) {
                                      bloc.add(GetStartDate(selectedDate));
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding,
                                      // vertical: kPadding2,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: context.moonColors!.beerus),
                                      borderRadius:
                                          BorderRadius.circular(kRadius),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                            MoonIcons.time_calendar_24_light,
                                            size: 22),
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
                              Gap(kPadding),
                              // const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () async {
                                    unFocus();

                                    final selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    bloc.add(GetStartTime(selectedTime!));
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding,
                                      // vertical: kPadding2,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: context.moonColors!.beerus),
                                        borderRadius:
                                            BorderRadius.circular(kRadius)),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          MoonIcons.time_stopwatch_24_light,
                                          size: 22,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          state.startTime == null
                                              ? t.event.selectTime
                                              : state.startTime!
                                                  .format(context),
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
                                flex: 2,
                                child: InkWell(
                                  onTap: () async {
                                    unFocus();

                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: now,
                                      firstDate: DateTime(
                                          now.year, now.month, now.day),
                                      lastDate: DateTime(2100),
                                    );
                                    if (selectedDate != null) {
                                      bloc.add(GetEndDate(selectedDate));
                                    }
                                  },
                                  child: Container(
                                    height: 50,

                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding,
                                      vertical: kPadding,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: context.moonColors!.beerus),
                                      borderRadius:
                                          BorderRadius.circular(kRadius),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          MoonIcons.time_calendar_24_light,
                                          size: 22,
                                        ),
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
                                    unFocus();

                                    final selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    bloc.add(GetEndTime(selectedTime!));
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding,
                                      // vertical: kPadding2,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: context.moonColors!.beerus),
                                        borderRadius:
                                            BorderRadius.circular(kRadius)),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          MoonIcons.time_stopwatch_24_light,
                                          size: 22,
                                        ),
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
                          Row(
                            children: [
                              MoonButton(
                                buttonSize: MoonButtonSize.sm,
                                showBorder: true,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(100),
                                borderColor: context.moonColors!.beerus,
                                onTap: () async {
                                  unFocus();

                                  final data = await showMoonModalBottomSheet(
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(30),
                                          ),
                                          child: SelectMusicPage());
                                    },
                                  );
                                  if (data != null) {
                                    bloc.add(GetMusic(data));
                                  }
                                },
                                label: Text(t.music.title),
                                trailing: Icon(
                                  MoonIcons.media_music_16_light,
                                  size: 20,
                                  color: context.moonColors!.beerus,
                                ),
                              ),
                              kPadding.gap,
                              MoonButton(
                                buttonSize: MoonButtonSize.sm,
                                showBorder: true,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(100),
                                borderColor: context.moonColors!.beerus,
                                onTap: () async {
                                  unFocus();

                                  bloc.add(SelectCoverImage());
        
                                },
                                label: Text(t.common.photo),
                                trailing: Icon(
                                  MoonIcons.media_photo_16_light,
                                  size: 20,
                                  color: context.moonColors!.beerus,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children:
                                state.selectMusie.asMap().entries.map((entry) {
                              final index = entry.key;
                              final music = entry.value;
                              return MoonMenuItem(
                                onTap: () {},
                                // absorbGestures: true,
                                menuItemPadding: EdgeInsets.zero,
                                label: Text(
                                  music.title,
                                  style: context.moonTypography!.body.text14
                                      .copyWith(
                                          color: context.moonColors!.piccolo),
                                ),
                                trailing: MoonButton.icon(
                                  
                                    onTap: () {
                                      debugPrint("click remvoe");
                                      bloc.add(ClickRemoveMusic(index));
                                    },
                                    icon: Icon(
                                        MoonIcons.controls_close_24_light,
                                        color: context.moonColors!.piccolo)),
                              );
                            }).toList(),
                          ),
                          Gap(kPadding2),  
                          
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
                                return Stack(
                                  children: [
                                    
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(kRadius),
                                        image: DecorationImage(
                                          image: FileImage(state.image[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          bloc.add(ClickClearImage(index));
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Text(
                                t.event.selectLocation,
                              ),
                              MoonButton.icon(
                                icon: Icon(MoonIcons.maps_location_24_light),
                                onTap: () {
                                  bloc.add(ClickCopyLatlong());
                                },
                              )
                            ],
                          ),
                          if (state.isShowFillLatlong)
                            TextFormField(
                              style:
                                  context.moonTypography!.body.text14.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                focusedBorder: focusedBorder,
                                enabledBorder: inputBorder,
                                isDense: true,
                                suffixIcon: MoonButton.icon(
                                  onTap: () async {
                                    const location =
                                        '11.609197096761273, 102.98204273276095';
                                    final coordinates = location
                                        .split(',')
                                        .map((e) => double.parse(e.trim()))
                                        .toList();
                                    bloc.add(
                                      GetLatLngFromMap(
                                          coordinates[0], coordinates[1]),
                                    );
                                    await _mapcontroller?.animateCamera(
                                      CameraUpdate.newLatLng(
                                        LatLng(coordinates[0], coordinates[1]),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.done_rounded,
                                    color: context.moonColors!.piccolo,
                                  ),
                                ),
                                hintText: t.event.pastLatlong,
                                hintStyle: context.moonTypography!.body.text16
                                    .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (value) async {
                                bloc.add(DescriptionChanged(value));
                              },
                            ),
                          kPadding.gap,
                          if (state.location.isNotEmpty)
                            Column(
                              children: [
                                Text(state.location),
                                kPadding.gap,
                              ],
                            ),
                          InkWell(
                            onTap: () async {
                              unFocus();

                              final LatLng? location =
                                  await showMoonModalBottomSheet<LatLng>(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
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
                                  onMapCreated:
                                      (GoogleMapController controller) {
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
                                        icon: BitmapDescriptor
                                            .defaultMarkerWithHue(
                                          BitmapDescriptor.hueRose,
                                        ),
                                      ),
                                  },
                                ),
                              ),
                            ),
                          ),
                          // kPadding2.gap
                        ],
                      ),
                    ),
                  ),
                  kPadding.gap,
                  CustomButtom(
                    isloading: state.isloading,
                    disable: !state.canCreate,
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
      ),
    );
  }
}
