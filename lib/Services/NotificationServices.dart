import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../AdditionalScreens/AlertScreen.dart';
import '../AdditionalScreens/MessageScreen.dart';
import '../AdditionalScreens/OtherScreen.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //Instance of Flutter Notification Plugin.
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
    const AndroidInitializationSettings("@mipmap/ic_launcher");

    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(context, message);
        });
  }


  void onMessage(BuildContext context) {
    ///TODO: onMessage listener
    FirebaseMessaging.onMessage.listen((message) {
      initLocalNotifications(context, message);
      if (message.notification!.title!.startsWith("alert")) {
        CustomNotification.alertNotification(message);
      } else if (message.notification!.title!.startsWith("message")) {
        CustomNotification.newMessageNotification(message);
      } else {
        CustomNotification.otherNotification(message);
      }
    });
  }


  Future<void> onMessageOpenedApp(BuildContext context) async {

    void handleNotification(RemoteMessage message) {
      if (message.notification!.title!.startsWith("alert")) {
        CustomNotification.alertNotification(message);
      } else if (message.notification!.title!.startsWith("message")) {
        CustomNotification.newMessageNotification(message);
      } else {
        CustomNotification.otherNotification(message);
      }
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleNotification(message);
      handleMessage(context, message);
    });

    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleNotification(initialMessage);
      handleMessage(context, initialMessage);
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print("Message ID" + message.data["_id"]);
    print("Message Type" + message.data["type"]);

    ///TODO:  Please Check for Navigation  with notification payload by uncommenting the below code and changing the Page route.

    if (message.data["type"] == "alert") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlertScreen()),
      );
    } else if (message.data["type"] == "message") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MessageScreen()));
    }
    else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const OtherScreen()));
    }
  }
}

///TODO: Custom Notifications Start-------------------------------------------->
class CustomNotification {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future init({bool scheduled = false}) async {
    var initAndroidSetting = const AndroidInitializationSettings(
        "@mipmap/ic_launcher");
    var ios = const DarwinInitializationSettings();
    final setting = InitializationSettings(
        android: initAndroidSetting, iOS: ios);
    await _notification.initialize(setting);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
  }

  ///Types of notification

  ///Notification for a New-Order.
  static void alertNotification(RemoteMessage message) async {
    try {
      Random random = Random();
      int id = random.nextInt(10000);

      ///Android Notification Details
      //First is channel id, second is channel name
      AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        "businessAdmin",
        "channelName",
        importance: Importance.max,
        priority: Priority.high,
        ticker: "ticker",
        enableVibration: true,
        playSound: true,
        sound: RawResourceAndroidNotificationSound("loud"),
      );

      ///IOS Notification Details
      DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
      );

      /// Setting notification Details for Android/IOS Platforms
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      ///Showing Notification using instance of FlutterLocalNotificationPlugin
      //Make sure in message.data['_id'], the id is with underscore when sending the payload data in notification.
      await Future.delayed(Duration.zero, () {
        _notification.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['_id'],
        );
      });
    } on Exception catch (e) {
      print('Error showing Notification--------->>>$e');
    }
  }

  ///Notification for a new Message.
  static void newMessageNotification(RemoteMessage message) async {
    try {
      Random random = Random();
      int id = random.nextInt(10000);

      ///Android Notification Details
      //First is channel id, second is channel name
      AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        "businessAdmin",
        "channelName",
        importance: Importance.max,
        priority: Priority.high,
        ticker: "ticker",
        enableVibration: true,
        playSound: true,
        sound: RawResourceAndroidNotificationSound("newsound"),
      );

      ///IOS Notification Details
      DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
      );

      /// Setting notification Details for Android/IOS Platforms
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      ///Showing Notification using instance of FlutterLocalNotificationPlugin
      //Make sure in message.data['_id'], the id is with underscore when sending the payload data in notification.
      await Future.delayed(Duration.zero, () {
        _notification.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['_id'],
        );
      });
    } on Exception catch (e) {
      print('Error showing Notification--------->>>$e');
    }
  }

  static void otherNotification(RemoteMessage message) async {
    try {
      Random random = Random();
      int id = random.nextInt(10000);

      ///Android Notification Details
      //First is channel id, second is channel name
      AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        "businessAdmin",
        "channelName",
        importance: Importance.max,
        priority: Priority.high,
        ticker: "ticker",
        enableVibration: true,
        playSound: true,
        sound: RawResourceAndroidNotificationSound("sms"),
      );

      ///IOS Notification Details
      DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
      );

      /// Setting notification Details for Android/IOS Platforms
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      ///Showing Notification using instance of FlutterLocalNotificationPlugin
      //Make sure in message.data['_id'], the id is with underscore when sending the payload data in notification.
      await Future.delayed(Duration.zero, () {
        _notification.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['_id'],
        );
      });
    } on Exception catch (e) {
      print('Error showing Notification--------->>>$e');
    }
  }
}
///Notification for a new Message.
// static void newMessageNotification(RemoteMessage message) async {
//   try {
//     Random random = Random();
//     int id = random.nextInt(10000);
//     const NotificationDetails notificationDetails =
//     NotificationDetails(
//       android: AndroidNotificationDetails(
//         "pushnotificationapp7",
//         "pushnotificationappchannel7",
//         importance: Importance.max,
//         priority: Priority.high,
//         sound: RawResourceAndroidNotificationSound("newsound"),
//       ),
//     );
//     await _notification.show(
//       id,
//       message.notification!.title,
//       message.notification!.body,
//       notificationDetails,
//       payload: message.data['_id'],
//     );
//   } on Exception catch (e) {
//     print('Error>>>$e');
//   }
// }

///Notification for Other things.
//   static void otherNotification(RemoteMessage message) async {
//     try {
//       Random random = Random();
//       int id = random.nextInt(10000);
//       const NotificationDetails notificationDetails =
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           "pushnotificationapp6",
//           "pushnotificationappchannel",
//           importance: Importance.max,
//           priority: Priority.high,
//           sound: RawResourceAndroidNotificationSound("sms"),
//         ),
//       );
//       await _notification.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: message.data['_id'],
//       );
//     } on Exception catch (e) {
//       print('Error>>>$e');
//     }
//   }
// }


/// Custom Notifications End--------------------------------------------------->
