import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // 백그라운드 메시지 처리 로직 추가
}

@pragma('vm:entry-point')
void backgroundHandler(NotificationResponse details) {
  // 백그라운드 알림 액션 처리 로직 추가
}

class NotificationController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    // 알림 권한 요청
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
        'high_importance_channel', 'high_importance_notification',
        importance: Importance.max));

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (details) {
        // 알림을 클릭했을 때의 처리 로직 추가
      },
      onDidReceiveBackgroundNotificationResponse: backgroundHandler,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Foreground 상태에서 푸시 알림 수신 처리
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          payload: message.data['test_parameter1'],
        );
        print("Foreground 상태에서 수신된 메시지: ${message.notification!.title}");
        print("메시지 내용: ${message.notification!.body}");
        print("클릭 액션: ${message.data["click_action"]}");
      }
    });

    // Background 상태에서 푸시 알림 수신 처리
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message != null) {
        print("Background 상태에서 수신된 메시지: ${message.notification!.title}");
        print("메시지 내용: ${message.notification!.body}");
        print("클릭 액션: ${message.data["click_action"]}");
      }
    });

    // Terminate 상태에서 푸시 알림 수신 처리
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("Terminate 상태에서 수신된 메시지: ${initialMessage.notification!.title}");
      print("메시지 내용: ${initialMessage.notification!.body}");
      print("클릭 액션: ${initialMessage.data["click_action"]}");
    }
  }

  Future<void> sendNotificationToDevice({
    required String deviceToken,
    required String title,
    required String content,
    required Map<String, dynamic> data,
  }) async {
    const String serverKey = "YOUR_SERVER_KEY"; // Firebase 서버 키
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final body = {
      'notification': {'title': title, 'body': content, 'data': data},
      'to': deviceToken,
    };

    final response = await http.post(url, headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      print("성공적으로 전송되었습니다.");
      print("$title $content");
    } else {
      print("전송에 실패하였습니다.");
    }
  }

  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $token");
  }
}
