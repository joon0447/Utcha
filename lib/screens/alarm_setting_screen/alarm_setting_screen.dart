import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AlarmSettingScreen extends StatefulWidget {
  const AlarmSettingScreen({super.key});

  @override
  State<AlarmSettingScreen> createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends State<AlarmSettingScreen> {
  String uid = 'aESOL5i5KtG2VnM8X6Au'; // 임시
  late bool notice; // 공지사항 알림
  late bool chat; // 채팅 알림
  late bool marketing; // 마케팅 동의


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
        ),
        title: const Text("알림 설정",    
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}