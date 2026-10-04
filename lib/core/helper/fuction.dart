// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hashids2/hashids2.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../di/di.dart';
import '../../features/band/domain/entities/band_entity.dart';
import '../../features/home/domain/entities/question_entity.dart';
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

Future<String> imageToBase64(File? imageFile) async {
  if (imageFile == null) {
    return '';
  } else {
    String? fileExtension = imageFile.path.split('.').last;
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return "data:image/$fileExtension;base64,$base64Image";
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

Future<void> shareQuestion(QuestionEntity q) async {
  try {
    QuestionEntity question = q;
    String message = '';
    final hashids = HashIds(salt: "eliezersSecret", minHashLength: 20);
    String obfuscated = hashids.encode([question.id]);
    String url = '${SharedPreferenceKeys.shareQuestion}$obfuscated';
    String questionMess = '';
    questionMess =
        question.title.isEmpty ? question.description : question.title;
    message = "${t.common.question.toLowerCase()}"
        " : "
        "$questionMess\n$url";
    await Share.share(message);
    // }
  } catch (value) {
    debugPrint("you have been error $value");
  }
}

Future<void> shareband(BandEntity q) async {
  try {
    BandEntity communtiy = q;
    String message = '';
    final hashids = HashIds(salt: "eliezersSecret", minHashLength: 20);
    String obfuscated = hashids.encode([communtiy.id]); // Output: "bM9kL0"
    String url = '${SharedPreferenceKeys.shareband}$obfuscated';
    String questionMess = '';
    questionMess =
        communtiy.name.isEmpty ? communtiy.description : communtiy.name;
    message = "${t.band.title.toLowerCase()}"
        " : "
        "$questionMess\n$url";
    await Share.share(message);
    // }
  } catch (value) {
    debugPrint("you have been error $value");
  }
}

Future<void> shareDiscussion(QuestionEntity q) async {
  try {
    QuestionEntity discussion = q;
    String message = '';
    final hashids = HashIds(salt: "eliezersSecret", minHashLength: 20);
    String encodeId = hashids.encode([discussion.id]);
    String url = '${SharedPreferenceKeys.shareDiscussion}$encodeId';
    String discussionMess = '';
    discussionMess =
        discussion.title.isEmpty ? discussion.description : discussion.title;
    message = "${t.common.question.toLowerCase()}"
        " : "
        "$discussionMess\n$url";
    await Share.share(message);
  } catch (value) {
    debugPrint("you have been error $value");
  }
}

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

class DeviceInfo {
  final String manufacturer;
  final String model;
  final String osVersion;
  DeviceInfo(
      {required this.manufacturer,
      required this.model,
      required this.osVersion});
}
