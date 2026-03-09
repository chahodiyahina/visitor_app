import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:visitor_app/screen/screens/dashboard/dashController.dart';
import 'package:visitor_app/screen/screens/dashboard/dashboard_view.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/visitor_controller.dart'
    show VisitorController;

class NotificationService {
  // Plugin used to show local notifications
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Navigator key used to navigate without context with flutter state
  // static final GlobalKey<NavigatorState> navigatorKey =
  //     GlobalKey<NavigatorState>();

  // ===============================
  // INIT FUNCTION
  // ===============================
  // Call this once in main.dart
  Future init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    // Initialize local notifications
    await flutterLocalNotificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // When user taps notification (foreground/local notification)
        String? payload = response.payload;
        print("get notification payload....$payload");
        if (payload != null) {
          navigateToScreen(payload);
        }
      },
    );

    requestPermission();
    firebaseInit();

    // ===============================
    // BACKGROUND TAP
    // ===============================
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationTap(message);
    });

    // ===============================
    // TERMINATED APP TAP
    // ===============================
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleNotificationTap(initialMessage);
    }
  }

  // ===============================
  // REQUEST NOTIFICATION PERMISSION
  // ===============================
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("Permission: ${settings.authorizationStatus}");
  }

  // ===============================
  // GET FCM TOKEN
  // ===============================
  static Future<String> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    print("FCM Token: $token");

    return token ?? "";
  }

  // ===============================
  // FOREGROUND MESSAGE LISTENER
  // ===============================
  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(message);
      }
    });
  }

  // ===============================
  // SHOW LOCAL NOTIFICATION
  // ===============================
  Future showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await flutterLocalNotificationsPlugin.show(
      id: notificationId,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: details,

      // Pass screen name when notification tapped
      payload: message.data['screen'],
    );
  }

  // ===============================
  // HANDLE NOTIFICATION TAP
  // ===============================
  void handleNotificationTap(RemoteMessage message) {
    String? screen = message.data['screen'];
    print("get notification payload....$screen");
    if (screen != null) {
      navigateToScreen(screen);
    }
  }

  // ===============================
  // NAVIGATION FUNCTION
  // ===============================
  /*static void navigateToScreen(String screen) {
    if (screen == "visitor") {
      navigatorKey.currentState?.pushNamed("/visitorPage");
    }

    if (screen == "home") {
      navigatorKey.currentState?.pushNamed("/home");
    }

    if (screen == "booking") {
      navigatorKey.currentState?.pushNamed("/bookingPage");
    }
  }*/
  static void navigateToScreen(String screen) {
    final DashController dashController = Get.find<DashController>();
    if (screen == "visitor") {
      Get.to(() => DashboardView());
      dashController.dashIndex.value = 1;
      final VisitorController visitorController = Get.find<VisitorController>();
      visitorController.tabController.index = 1;
    }

    // if (screen == "home") {
    //   Get.toNamed("/home");
    // }
    //
    // if (screen == "booking") {
    //   Get.toNamed("/bookingPage");
    // }
  }
}
