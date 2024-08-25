import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// auth 연동 후 사용
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utcha/screens/account_info_screen/account_info_screen.dart';
import 'package:utcha/screens/address_setting_screen/address_setting_screen.dart';
import 'package:utcha/screens/adjustment_screen/adjustment_screen.dart';
import 'package:utcha/screens/alarm_setting_screen/alarm_setting_screen.dart';
import 'package:utcha/screens/join_post_screen/join_post_screen.dart';
import 'package:utcha/screens/like_post_screen/like_post_screen.dart';
import 'package:utcha/screens/money_account_info_screen/money_account_info.dart';
import 'package:utcha/screens/mypage_main_screen/logout_widget.dart';
import 'package:utcha/screens/profile_setting_screen/profile_change_widget.dart';
import 'package:utcha/screens/profile_setting_screen/profile_setting_screen.dart';
import 'package:utcha/screens/terms_of_use_screen/service_screen.dart';
import 'package:utcha/screens/upload_post_screen/upload_post_screen.dart';

class MypageMainScreen extends StatefulWidget {
  const MypageMainScreen({super.key});

  @override
  State<MypageMainScreen> createState() => _MypageMainScreenState();
}

class _MypageMainScreenState extends State<MypageMainScreen> {
  // String uid = FirebaseAuth.instance.currentUser!.uid; // 로그인 기능 연동 후 사용
  String uid = 'aESOL5i5KtG2VnM8X6Au'; // 임시

  getUserInfo() async {
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return result.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "마이페이지",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          scrolledUnderElevation: 0,
        ),
        body: FutureBuilder(
            future: getUserInfo(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 20, bottom: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                            (snapshot.data
                                                as Map)['profileUrl'], // 프로필 사진
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (snapshot.data
                                                  as Map)['displayName'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ), // 닉네임
                                            Text(
                                              formatPhoneNum(
                                                  '0${(snapshot.data as Map)['phoneNumber'].toString().substring(3)}'),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ), // 전화번호
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProfileSettingScreen(),
                                            ),
                                          );
                                      },
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_sharp))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        const Color.fromARGB(99, 224, 224, 224),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, right: 30, left: 30),
                                  width:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LikePostScreen(),
                                            ),
                                          );
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(Icons.thumb_up),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "좋아요한 글",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const UploadPostScreen(),
                                            ),
                                          );
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(Icons.thumb_up),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("업로드한 글",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const JoinPostScreen(),
                                            ),
                                          );
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(Icons.thumb_up),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("참여한 글",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Title(text: "개인 정보"),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountInfoScreen()),
                                    );
                                  },
                                  child: const Menu(text: "계정 정보")),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MoneyAccountInfo()),);
                                },
                                child: const Menu(text: "계좌 관리")),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AdjustmentScreen()));
                                },
                                child: const Menu(text: "정산 관리")),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressSettingScreen()));
                                },
                                child: const Menu(text: "주소 설정")),
                              const Title(text: "알림 설정"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AlarmSettingScreen()));
                                },
                                child: const Menu(text: "알림 수신 설정")),
                              const Title(text: "기타"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ServiceScreen()));
                                },
                                child: const Menu(text: "서비스 이용 약관")),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "앱 버전",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "1.0.0",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 197, 197, 197),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              

                              GestureDetector(
                                onTap: (){
                                  logOutDialog(context);
                                },
                                child: const Menu2(text: "로그아웃")),
                              GestureDetector(
                                onTap: () {
                                  print("dd");
                                },
                                child: const Menu2(text: "서비스 탈퇴")),
                              const Title(text: "읏차 고객센터"),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.call),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "1588-1010",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(Icons.mail),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "문의하기",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator());
            }));
  }

  String formatPhoneNum(String phoneNumber) {
    // 전화번호 01012345678 -> 010-1234-5678 변환
    return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}';
  }
}

class Title extends StatelessWidget {
  final String text;
  const Title({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final String text;
  const Menu({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.grey, size: 18),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class Menu2 extends StatelessWidget {
  final String text;
  const Menu2({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
