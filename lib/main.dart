import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app/app.dart';
import 'core/utils/log/app_logger.dart';
import 'gen/i18n/translations.g.dart';
import 'app/app_initializer.dart';

void main() => runZonedGuarded(_runMyApp, _reportError);

void _runMyApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 1));
  FlutterNativeSplash.remove();
  await AppInitializer().init();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  debugPrint("device token $token");
  // await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
  runApp(TranslationProvider(child: const MyApp()));
}

void _reportError(Object error, StackTrace stack) {
  error.logE(stackTrace: stack);
}
