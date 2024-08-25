import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:utcha/screens/user_screens/Login_screen.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({super.key});

  @override
  State<ChangePhoneScreen> createState() => _FindpasswordScreenState();
}

class _FindpasswordScreenState extends State<ChangePhoneScreen> {
  bool _isEmailButtonEnabled = false;
  bool _isPhoneButtonEnabled = false;
  String _email = "";

  final TextEditingController _emailController = TextEditingController(); // 이메일 검증
  final TextEditingController _phoneController = TextEditingController(); // 전화번호 검증
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  @override
  void initState(){
    super.initState();
    _emailController.addListener(_validateEmail);
    _phoneController.addListener(_validatePhoneNumber);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _validateEmail() { // 메일 검증
    setState(() {
      _isEmailButtonEnabled = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text);
    });
  }

  void _validatePhoneNumber() { // 전화번호 검증
    setState(() {
      _isPhoneButtonEnabled = RegExp(r'^010[0-9]{8}$').hasMatch(_phoneController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            }, icon: const Icon(Icons.arrow_back)),
        title: const Text("전화번호 변경"),
        centerTitle: true,
      ),
      body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "이메일 주소 입력",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          "가입 시 이용한 이메일 주소를 입력해주세요.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "이메일 주소",
                              style: TextStyle(fontSize: 15),
                            ),
                            TextField(
                              controller : _emailController,
                              decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                                  labelText: "이메일을 입력해주세요."),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isEmailButtonEnabled ? () {
                        _email = _emailController.text;
                        setState(() {
                              _email = _emailController.text;
                            });
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "이메일 인증",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "인증번호 입력",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text("$_email 으로 전송된 인증번호를 입력해주세요.",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "인증번호",
                              style: TextStyle(fontSize: 15),
                            ),
                            TextField(
                              decoration: InputDecoration(
                              border: OutlineInputBorder(),
                                  labelText: "인증번호를 입력해주세요."),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isEmailButtonEnabled ? () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "이메일 인증",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "전화번호 입력",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          "변경된 전화번호를 입력해주세요.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "전화번호",
                              style: TextStyle(fontSize: 15),
                            ),
                            TextField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "전화번호를 입력해주세요."),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isPhoneButtonEnabled ? () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      } : null ,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "전화번호 인증",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(17),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "전화번호 변경이",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    ),
                    const Text(
                      "완료되었습니다.",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text(
                            "로그인 하러 가기",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
    );
  }

}
