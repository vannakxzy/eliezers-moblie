import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../config/router/page_route/app_route_info.dart';
import '../../../di/di.dart';
import '../../../features/profile/domain/entities/answer_entity.dart';

import '../../../app/base/navigation/app_navigator.dart';
import '../local_data/storge_local.dart';

// import 'package:flutter_app_badger/flutter_app_badger.dart';

Future checkForInitalMessge() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage().then((value) {
    if (value != null) {
      handleRoute(value);
    }
  });
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_cannel', 'high Importance Notification',
    importance: Importance.high, playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
int i = 0;
void listNotification() async {
  i = i + 2;
  // FlutterAppBadger.updateBadgeCount(0);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  String? token = await messaging.getToken();
  debugPrint("device token $token");

  if (messaging.isAutoInitEnabled) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleRoute(message);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("get messages ${message.data}");

      addNotification();
      RemoteNotification? notification = message.notification;

      if (message.notification != null) {
        if (Platform.isAndroid) {
          await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.createNotificationChannel(channel);
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: '@mipmap/ic_launcher',
                importance: Importance.high,
              ),
              iOS: const DarwinNotificationDetails(),
            ),
          );
        }

        await flutterLocalNotificationsPlugin.initialize(
          const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings(),
          ),
          onDidReceiveNotificationResponse:
              (NotificationResponse notificationResponse) {
            debugPrint("tap on notification ${message.data}");
            handleRoute(message);
          },
        );
      }
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      debugPrint(" notificationdata ${message.data}");
      handleRoute(message);
    });
  } else {
    debugPrint('User declined or has not accepted permission');
  }
}

void handleRoute(RemoteMessage message) {
  try {
    var data = message.data;
    int answerId = int.parse(data['answer_id']);
    int commentId = int.parse(data['comment_id']);
    int questionId = int.parse(data['question_id']);
    debugPrint(" notificationdata ${message.data}");
    if (commentId != 0 && answerId != 0) {
      getIt.get<IAppNavigator>().push(AppRouteInfo.commentInAnswer(
          answerId, AnswertEntity(), commentId, 0));
    } else {
      getIt.get<IAppNavigator>().push(AppRouteInfo.questionDetail(
            id: questionId,
            questionEntity: null,
            answerId: answerId,
            commentId: commentId,
          ));
    }
  } catch (value) {
    debugPrint("$value");
  }
}

void addNotification() async {
  try {
    int number = LocalStorage.getIntValue('numberNotificaiton');
    await LocalStorage.storeData(key: 'numberNotificaiton', value: number + 1);
  } catch (e) {
    debugPrint("catch $e");
  }
}

void subtractNotification() async {
  int number = LocalStorage.getIntValue('numberNotificaiton');
  await LocalStorage.storeData(key: 'numberNotificaiton', value: number - 1);
}

void countNotification() async {}
