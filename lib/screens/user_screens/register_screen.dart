import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utcha/screens/user_screens/validate.dart';

class RegisterUi extends StatefulWidget {
  @override
  _RegisterUiState createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('회원가입', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                decoration: InputDecoration(
                  labelText: '이름',
                  hintText: '이름을 입력해주세요.',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return CheckValidate().validateName(_nameFocusNode, value!);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelText: '이메일 주소',
                  hintText: '이메일 주소를 입력해주세요.',
                  border: OutlineInputBorder(),
                  suffixIcon: TextButton(
                    onPressed: () {
                      // 중복 확인 버튼
                    },
                    child: Text('중복확인'),
                  ),
                ),
                validator: (value) {
                  return CheckValidate().validateEmail(_emailFocusNode, value!);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  hintText: '비밀번호를 입력해주세요.',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  return CheckValidate().validatePassword(_passwordFocusNode, value!);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  hintText: '비밀번호를 재입력해주세요.',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return '비밀번호가 일치하지 않습니다.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                decoration: InputDecoration(
                  labelText: '휴대폰 번호',
                  hintText: '휴대폰 번호를 입력해주세요.',
                  border: OutlineInputBorder(),
                  suffixIcon: TextButton(
                    onPressed: () {
                      // 인증 요청 버튼
                    },
                    child: Text('인증요청'),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                  PhoneInputFormatter(), // 전화번호 포맷터 적용
                ],
                validator: (value) {
                  return CheckValidate().validatePhoneNumber(_phoneFocusNode, value!);
                },
              ),
              SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // 모든 필드가 유효할 때의 동작을 정의하세요.
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '다음',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
