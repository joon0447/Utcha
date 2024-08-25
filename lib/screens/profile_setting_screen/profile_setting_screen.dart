import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utcha/screens/mypage_main_screen/mypage_main_screen.dart';
import 'package:utcha/screens/profile_setting_screen/profile_change_widget.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  String uid = 'aESOL5i5KtG2VnM8X6Au'; // 임시
  late TextEditingController _nameController;
  late TextEditingController _introController;
  getUserInfo() async {
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return result.data();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _introController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "프로필 설정",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        body: FutureBuilder(
          future: getUserInfo(),
          builder: (context, snapshot) {
            _nameController = TextEditingController(text : (snapshot.data as Map)['displayName']);
            _introController = TextEditingController(text : (snapshot.data as Map)['selfIntroduction']);
            return snapshot.hasData
                ? Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                            (snapshot.data
                                                as Map)['profileUrl'], // 프로필 사진
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover),
                                      )
                                    ],
                                  ),
                                  const Positioned(
                                      right: 140,
                                      top: 80,
                                      child: Icon(
                                        Icons.photo_camera_outlined,
                                        color:
                                            Color.fromARGB(255, 155, 155, 155),
                                      ))
                                ],
                              ),
                            ),
                            const Row(
                              children: [
                                Text(
                                  "닉네임",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Text("자기소개",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _introController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                            onTap: () {
                              ChangeDialog(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.08,
                              color: Colors.black,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "저장",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
