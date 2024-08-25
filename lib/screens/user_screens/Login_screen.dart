import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 기능 구현
          },
        ),
        title: const Text('로그인'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _loginFailed = false;

  void _login() {
    setState(() {
      _loginFailed = true; // 로그인 실패 시 상태 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60), // 상단에서 더 내려오기 위해 높이 조정
              const Text(
                '로그인하기',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              const Text(
                '로그인 정보를 입력해주세요.',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold), // 볼드 체 및 16px
              ),
              const SizedBox(height: 32), // 간격을 늘리기 위해 32로 설정
              const Text(
                '이메일주소',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5), // 간격을 1px 추가하여 17로 설정
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: '이메일을 입력해주세요',
                ),
              ),
              const SizedBox(height: 20), // 간격을 늘리기 위해 32로 설정
              const Text(
                '비밀번호',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5), // 간격을 1px 추가하여 17로 설정
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: '비밀번호를 입력해주세요',
                ),
              ),
              const SizedBox(height: 5),
              if (_loginFailed)
                const Text(
                  '아이디 또는 비밀번호가 올바르지 않습니다.',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // 비밀번호 재설정 화면으로 이동
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: '비밀번호가 기억나지 않으시나요? ',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      children: <TextSpan>[
                        TextSpan(
                          text: '비밀번호 재설정',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0), // 로그인 버튼 아래에 8px 여백 추가
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // 버튼 배경색
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // 사각형 모양
                  ),
                ),
                onPressed: _login, // 로그인 처리 로직
                child: const Text(
                  '로그인',
                  style: TextStyle(color: Colors.white), // 버튼 글씨 색상
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
