import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sample_flutterfire_notifications/br/com/codersconcept/controllers/auth_service.dart';
import 'package:sample_flutterfire_notifications/br/com/codersconcept/controllers/crud_service.dart';
import 'package:sample_flutterfire_notifications/main.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true
    );
  }

  static Future<void> getDeviceToken() async {
    final token = await _firebaseMessaging.getToken();
    debugPrint("Device token: $token");
    bool isUserLoggedIn = await AuthService.isLoggedIn();

    if (isUserLoggedIn) {
      await CrudService.saveUserToken(token!);
      debugPrint("Token saved");
    }

    _firebaseMessaging.onTokenRefresh.listen((event) async {
      if (isUserLoggedIn) {
        await CrudService.saveUserToken(token!);
        debugPrint("Token saved");
      }
    });
  }

  static Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
    final DarwinInitializationSettings darwinInitializationSettings =
      DarwinInitializationSettings(onDidReceiveLocalNotification: (id, title, body, payload) => null);
    final InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings, iOS: darwinInitializationSettings);

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap
    );
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorKey.currentState!.pushNamed("/message", arguments: notificationResponse);
  }
  
  static Future<void> showSimpleNotification({required String title, required String body, required String payload}) async {
    const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        "foreground_notifications",
        "foreground_notifications",
        channelDescription: "Notifications on app opened",
        importance: Importance.max,
        priority: Priority.high,
      );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
  }
}