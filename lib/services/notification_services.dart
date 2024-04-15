import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../constant/exports.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("Permission granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("Permission Provissional");
    } else {
      // AppSettings.openAppSettings(
      //   type: AppSettingsType.notification,
      // );
      debugPrint("Permission dened");
    }
    getDeviceToken();
    firbaseInit();
  }

  void getDeviceToken() async {
    String? fcmToken = await messaging.getToken();

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'UserToken': fcmToken!});
    debugPrint(
        "............................fcm..........................................");
    debugPrint(fcmToken);
    debugPrint(
        "......................................................................");
  }

  void firbaseInit() {
    FirebaseMessaging.onMessage.listen((msg) {
      // debugPrint(
      //     "......................................................................");
      // debugPrint(msg.notification!.title.toString());
      // debugPrint(msg.notification!.body.toString());
      // debugPrint(
      //     "......................................................................");
      showNotification(msg);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(Random.secure().nextInt(100000).toString(),
            'Hight Importance Notification',
            importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id.toString(),
            androidNotificationChannel.name.toString(),
            channelDescription: 'Safar-e-kalam',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      _localNotification.show(1, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });
  }

  Future<void> initializeNotification(
      BuildContext context, RemoteMessage message) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // Replace with your app icon

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotification.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {});
  }
}
