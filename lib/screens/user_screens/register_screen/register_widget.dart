import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/services/user_service.dart';
import 'register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RegisterController(
      formKey: GlobalKey<FormState>(),
      phoneController: TextEditingController(),
      verificationCodeController: TextEditingController(),
      phoneFocusNode: FocusNode(),
      verificationCodeFocusNode: FocusNode(),
      userService: UserService(),
      onVerificationStateChanged: (isVerificationFieldVisible) {
        setState(() {
          _controller.isVerificationFieldVisible = isVerificationFieldVisible;
        });
      },
      onError: (errorMessage) {
        setState(() {
          _controller.errorMessage = errorMessage;
        });
      },
      onVerificationIdReceived: (verificationId) {
        setState(() {
          _controller.verificationId = verificationId;
        });
      },
      context: context,  // context를 명시적으로 전달
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('회원가입', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controller.phoneController,
                focusNode: _controller.phoneFocusNode,
                decoration: InputDecoration(
                  hintText: '휴대폰 번호를 입력해주세요.',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500, width: 1.3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1.3),
                  ),
                  // 인증요청버튼
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 5.0, top: 6.0, bottom: 6.0),
                    child: SizedBox(
                      width: 95,
                      child: ElevatedButton(
                        onPressed: _controller.requestVerificationCode,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                        child: const Text('인증요청', style: TextStyle(fontSize: 15)),
                      ),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  PhoneInputFormatter(),
                ],
                validator: (value) {
                  return CheckPhoneNumberValidate().validatePhoneNumber(_controller.phoneFocusNode, value!);
                },
              ),
              const SizedBox(height: 16),
              if (_controller.isVerificationFieldVisible) ...[
                TextFormField(
                  controller: _controller.verificationCodeController,
                  focusNode: _controller.verificationCodeFocusNode,
                  decoration: InputDecoration(
                    hintText: '인증번호를 입력해주세요.',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade500, width: 1.3),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.3),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      _controller.verificationCodeFocusNode.requestFocus();
                      return '인증번호를 입력하세요.';
                    }
                    return null;
                  },
                ),
                if (_controller.errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _controller.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],
                const SizedBox(height: 32),
              ],
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: _controller.isVerificationFieldVisible ? () => _controller.verifyCode(_controller.verificationId!) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '회원가입',
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
