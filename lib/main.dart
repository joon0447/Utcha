import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:utcha/firebase_options.dart';
import 'package:utcha/screens/user_screens/main_home_screen/main_home_screen_widget.dart';
import 'package:utcha/screens/user_screens/notification_screen/notification_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseMessaging Background Handler 설정
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Notification 초기화
  NotificationController().initializeNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Utcha',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
      ),
      home: MainHomeScreen(),
    );
  }
}
