import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:utcha/firebase_options.dart';
import 'package:utcha/screens/mypage_main_screen/mypage_main_screen.dart';
import 'package:utcha/screens/profile_setting_screen/profile_setting_screen.dart';
import 'package:utcha/screens/user_screens/changePhone_screen.dart';
import 'screens/user_screens/Login_screen.dart';
import 'screens/user_screens/register_screen.dart'; // registerUi 파일

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utcha',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const MypageMainScreen(),
    );
  }
}
