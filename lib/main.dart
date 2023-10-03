import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'Screens/HomeScreen.dart';
import 'Services/NotificationServices.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  ///TODO: Here we are selecting the type of notification which we made in CustomNotification.dart
  ///We  have made three types of notifications in CustomNotification.dart file.
  if (message.notification!.title!.startsWith("alert")) {
    CustomNotification.alertNotification(message);
  } else if (message.notification!.title!.startsWith("message")) {
    CustomNotification.newMessageNotification(message);
  } else {
    CustomNotification.otherNotification(message);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///Made instance of NotificationServices class we made in notification_services file
  NotificationServices notificationServices = NotificationServices();
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///To interact with notification when app in background
    notificationServices.onMessage(context);
    ///To interact with notification when app in active
    notificationServices.onMessageOpenedApp(context);

    notificationServices.getDeviceToken().then((value) => {
      print(
          "Device Token------------------------------------------------------>"),
      print(value),
    });
    
  }

  @override
  Widget build(BuildContext context) {
    CustomNotification.init();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}