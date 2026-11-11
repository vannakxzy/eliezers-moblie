// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hashids2/hashids2.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../di/di.dart';
import '../../features/profile/domain/entities/profile_entity.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../gen/i18n/translations.g.dart';
import '../constants/constants.dart';

String combineDateAndTime(
  String dateString,
  TimeOfDay time,
) {
  final date = DateTime.parse(dateString);

  final dateTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );

  return dateTime.toUtc().toIso8601String();
}

String formatToKhmer(String number) {
  // Khmer numbers from 0 to 9
  List<String> khmerDigits = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];

  String result = '';
  String numberStr = number.toString();
  for (int i = 0; i < numberStr.length; i++) {
    int digit = int.parse(numberStr[i]);
    result += khmerDigits[digit];
  }

  return result;
}

final ImagePicker picker = ImagePicker();
bool checkStringIsgmail({required String value}) {
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(value);
}
Future<String> getAudioDuration(PlatformFile file) async {
  final player = AudioPlayer();

  try {
    await player.setSource(DeviceFileSource(file.path!));

    final duration = await player.getDuration();

    if (duration == null) return "0:00";

    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  } catch (e) {
    return "0:00";
  } finally {
    await player.dispose();
  }
}

Future<List<File>> pickMultipleImages() async {
  final ImagePicker picker = ImagePicker();

  final List<XFile> images = await picker.pickMultiImage();

  return images.map((image) => File(image.path)).toList();
}

Future<String?> downloadMp3(String url, String fileName) async {
  try {
    String filePath;

    if (Platform.isAndroid) {
      // Request storage permission
      if (!await Permission.storage.request().isGranted) {
        debugPrint("Storage permission denied");
        return null;
      }

      // Save to Downloads folder
      Directory downloadsDir = Directory("/storage/emulated/0/Download");
      filePath = "${downloadsDir.path}/$fileName.mp3";
    } else if (Platform.isIOS) {
      // Save to app's Documents folder
      Directory dir = await getApplicationDocumentsDirectory();
      filePath = "${dir.path}/$fileName.mp3";
    } else {
      debugPrint("Unsupported platform");
      return null;
    }

    // Download the file
    Dio dio = Dio();
    await dio.download(url, filePath);

    debugPrint("✅ File saved at: $filePath");
    return filePath;
  } catch (e) {
    debugPrint("❌ Download failed: $e");
    return null;
  }
}

Future unFocus() async {
  FocusManager.instance.primaryFocus?.unfocus();
}
Future<File> base64ToMp3(String base64String) async {
  // Remove Data URI prefix
  final String cleanBase64 =
      base64String.contains(',') ? base64String.split(',').last : base64String;

  // Decode Base64
  final bytes = base64Decode(cleanBase64);

  // Save MP3
  final file = File('${Directory.systemTemp.path}/music.mp3');

  await file.writeAsBytes(bytes, flush: true);

  return file;
}

String getSongTitle(String lyrics) {
  final match = RegExp(r'\{title:\s*(.*?)\}').firstMatch(lyrics);
  return match?.group(1) ?? '';
}

Future<String> audioToBase64(File? audioFile) async {
  if (audioFile == null) return '';

  try {
    final bytes = await audioFile.readAsBytes();
    return base64Encode(bytes); // No Data URI prefix
  } catch (e) {
    debugPrint('Audio conversion error: $e');
    return '';
  }
}

Future<String> ddddddd(PlatformFile? file) async {
  try {
    if (file == null) return '';

    final bytes = file.bytes ??
        (file.path != null ? await File(file.path!).readAsBytes() : null);

    if (bytes == null) return '';

    return 'data:audio/mpeg;base64,${base64Encode(bytes)}';
  } catch (e) {
    debugPrint('Audio convert error: $e');
    return '';
  }
}

Future<String> imageToBase64(File? file) async {
  try {
    if (file == null) return '';

    final extension = file.path.split('.').last.toLowerCase();
    final bytes = await file.readAsBytes();
    final base64Data = base64Encode(bytes);

    String mimeType;

    switch (extension) {
      case 'jpg':
      case 'jpeg':
        mimeType = 'image/jpeg';
        break;
      case 'png':
        mimeType = 'image/png';
        break;
      case 'webp':
        mimeType = 'image/webp';
        break;
      case 'mp3':
        mimeType = 'audio/mpeg';
        break;
      default:
        mimeType = 'application/octet-stream';
    }

    return 'data:$mimeType;base64,$base64Data';
  } catch (e) {
    debugPrint('Convert error: $e');
    return '';
  }
}

Future<List> pickMultiImage() async {
  var listimage = await picker.pickMultiImage();
  return listimage;
}

Future<File> cropImage(File file) async {
  final newFile = await ImageCropper().cropImage(
    sourcePath: file.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Profile Picture',
        toolbarColor: Colors.blue,
        cropGridColumnCount: 3,
        cropGridRowCount: 3,
        toolbarWidgetColor: Colors.white,

        initAspectRatio:
            CropAspectRatioPreset.ratio5x3, // Allow free cropping otherwise
        lockAspectRatio: false, // Lock the aspect ratio if true
      ),
      IOSUiSettings(
        title: 'Crop Profile Picture',
        minimumAspectRatio: 0.5,
        aspectRatioLockEnabled: false, // Lock the aspect ratio if true
      ),
    ],
  );
  return File(newFile!.path);
}

Future<File> cropProfile(File file) async {
  final newFile = await ImageCropper().cropImage(
    sourcePath: file.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Profile Picture',
        toolbarColor: Colors.blue,
        cropGridColumnCount: 3,
        cropGridRowCount: 3,
        toolbarWidgetColor: Colors.white,

        initAspectRatio:
            CropAspectRatioPreset.ratio5x3, // Allow free cropping otherwise
        lockAspectRatio: false, // Lock the aspect ratio if true
      ),
      IOSUiSettings(
        title: 'Crop Profile Picture',
        minimumAspectRatio: 0.5,
        aspectRatioLockEnabled: false, // Lock the aspect ratio if true
      ),
    ],
  );

  return File(newFile!.path);
}

String cleanText(String input) {
  return input
      .split('\n') // Split the input string into lines
      .where((line) =>
          line.trim().isNotEmpty ||
          line.isEmpty) // Keep empty and non-empty lines
      .fold<List<String>>([], (result, line) {
    if (line.isNotEmpty || (result.isNotEmpty && result.last.isNotEmpty)) {
      result.add(line);
    }
    return result;
  }).join('\n'); // Join the cleaned lines with newldfdfdines
}

Future<File> pickImage({ImageSource source = ImageSource.gallery}) async {
  final picker = ImagePicker();
  var image = await picker.pickImage(source: source);

  if (image == null) {
    throw Exception('No image selected');
  }
  File originalImageFile = File(image.path);
  int originalImageSizeBytes = await originalImageFile.length();
  const int sizeLimitBytes = 800 * 1024;
  if (originalImageSizeBytes > sizeLimitBytes) {
    int quality = (sizeLimitBytes / originalImageSizeBytes * 100).round();
    quality = quality < 1 ? 1 : quality; // Ensure quality is at least 1
    final dir = await getTemporaryDirectory();
    final targetPath =
        path.join(dir.absolute.path, 'compressed_${path.basename(image.path)}');
    var compressedImage = await FlutterImageCompress.compressAndGetFile(
      image.path,
      targetPath,
      quality: quality,
    );
    if (compressedImage == null) {
      throw Exception('Image compression failed');
    }
    int compressedImageSizeBytes = await compressedImage.length();
    debugPrint(
        "Original Image Size: ${(originalImageSizeBytes / 1024).toStringAsFixed(2)} KB");
    debugPrint(
        "Compressed Image Size: ${(compressedImageSizeBytes / 1024).toStringAsFixed(2)} KB");
    return File(compressedImage.path);
  } else {
    debugPrint(
        "Original not compress : ${(originalImageSizeBytes / 1024).toStringAsFixed(2)} KB");
    return originalImageFile;
  }
}

Future saveImage(String urlImage) async {
  var response = await getIt
      .get<Dio>()
      .get(urlImage, options: Options(responseType: ResponseType.bytes));
  await ImageGallerySaverPlus.saveImage(Uint8List.fromList(response.data),
      quality: 60, name: "hello");
}

extension RangeCheck on int {
  bool isBetween(int min, int max) => this > min && this < max;
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 100,
      right: 20,
      left: 20,
    ),
  ));
}

Color rendomColors() {
  int i = Random().nextInt(4) + 1;
  if (i == 1) {
    return const Color.fromARGB(255, 202, 88, 1);
  } else if (i == 2) {
    return const Color.fromARGB(255, 10, 104, 152);
  } else if (i == 3) {
    return const Color.fromARGB(255, 186, 7, 7);
  } else {
    return const Color.fromARGB(255, 29, 161, 82);
  }
}

// Future<void> shareQuestion( ) async {
//   try {
//     QuestionEntity question = q;
//     String message = '';
//     final hashids = HashIds(salt: "eliezersSecret", minHashLength: 20);
//     String obfuscated = hashids.encode([question.id]);
//     String url = '${SharedPreferenceKeys.shareQuestion}$obfuscated';
//     String questionMess = '';
//     questionMess =
//         question.title.isEmpty ? question.description : question.title;
//     message = "${t.common.question.toLowerCase()}"
//         " : "
//         "$questionMess\n$url";
//     await Share.share(message);
//     // }
//   } catch (value) {
//     debugPrint("you have been error $value");
//   }
// }




Future<void> shareUser(ProfileEntity u) async {
  try {
    debugPrint("you shareing the user ");
    ProfileEntity user = u;
    String message = '';
    final hashids = HashIds(salt: "eliezersSecret", minHashLength: 20);
    String encodeId = hashids.encode([user.id]);
    String userUrl = '${SharedPreferenceKeys.shareUser}$encodeId';
    message = "${t.common.name} : ${user.name}\n $userUrl";
    await Share.share(message);
  } catch (value) {
    debugPrint("you have been error $value");
  }
}
void openGoogleMap(
    {context,
    required double lat,
    required double lng,
    String title = ""}) async {
  try {
    final coords = Coords(lat, lng);
    final availableMaps = await MapLauncher.installedMaps;
    if (availableMaps.length == 1) {
      availableMaps.first.showDirections(destination: coords);
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(children: [
                    Text(
                      "Open In",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      for (var map in availableMaps)
                        GestureDetector(
                          onTap: () {
                            map.showMarker(
                              coords: coords,
                              title: title,
                            );
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  // child: SvgPicture.asset(
                                  //   map.icon,
                                  //   fit: BoxFit.contain,
                                  // ),
                                ),
                                Text(map.mapName),
                              ])),
                        )
                    ])
                  ])));
        },
      );
    }
  } catch (e) {
    debugPrint("$e");
  }
}
Future<void> shareSong(ProfileEntity u) async {
  try {
    debugPrint("you shareing the user ");
    ProfileEntity user = u;
    String message = '';
    final hashids = HashIds(salt: "eliezersSecret", minHashLength: 20);
    String encodeId = hashids.encode([user.id]);
    String userUrl = '${SharedPreferenceKeys.shareUser}$encodeId';
    message = "${t.common.name} : ${user.name}\n $userUrl";
    await Share.share(message);
  } catch (value) {
    debugPrint("you have been error $value");
  }
}

Future<DeviceInfo> getDeviceInfo() async {
  try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return DeviceInfo(
          manufacturer: androidInfo.manufacturer,
          model: androidInfo.model,
          osVersion: androidInfo.version.release);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return DeviceInfo(
          manufacturer: "Apple",
          model: iosInfo.model,
          osVersion: iosInfo.systemVersion);
    }
    return DeviceInfo(
        manufacturer: "unknown", model: "unknown", osVersion: "unknown");
  } catch (vluae) {
    debugPrint("dfsdf$vluae");
    return DeviceInfo(
        manufacturer: "unknown", model: "unknown", osVersion: "unknown");
  }
}
Future<String> getAddressFromLatLng(double lat, double long) async {
  try {
    final Geocoding geocoding = Geocoding();
    List<Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(lat, long);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String address =
          "${place.street} ${place.isoCountryCode}, ${place.subLocality}, ${place.locality}, ${place.country}";
      debugPrint("address $address");
      return address;
    } else {
      return 'No Address Found';
    }
  } catch (e) {
    return 'Not Found';
  }
}

Future<PlatformFile?> pickMp3() async {
  try {
    debugPrint("Picking...........MP3");
    final result = await FilePicker.pickFiles(
      type: FileType.audio,
      // allowedExtensions: ['mp3'],
      allowMultiple: false,
      // withData: false,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }
    final file = result.files.single;
    debugPrint('Name: ${file.name}');
    debugPrint('Path: ${file.path}');
    debugPrint('Size: ${file.size}');

    return file;
  } catch (e) {
    debugPrint('File picker error: $e');
    return null;
  }
}

class DeviceInfo {
  final String manufacturer;
  final String model;
  final String osVersion;
  DeviceInfo(
      {required this.manufacturer,
      required this.model,
      required this.osVersion});
}
