import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/user_record.dart';
import '../../../data/services/user_service.dart';
import '../helper_home_screen/helper_home_screen_widget.dart';
import 'package:flutter/services.dart';

class RegisterController {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController verificationCodeController;
  final FocusNode phoneFocusNode;
  final FocusNode verificationCodeFocusNode;
  final UserService userService;
  final Function(bool) onVerificationStateChanged;
  final Function(String) onError;
  final Function(String) onVerificationIdReceived;
  final BuildContext context; // 추가된 부분: context 전달

  bool isVerificationFieldVisible = false;
  String? verificationId;
  String? errorMessage;

  RegisterController({
    required this.formKey,
    required this.phoneController,
    required this.verificationCodeController,
    required this.phoneFocusNode,
    required this.verificationCodeFocusNode,
    required this.userService,
    required this.onVerificationStateChanged,
    required this.onError,
    required this.onVerificationIdReceived,
    required this.context, // 추가된 부분: context 전달
  });

  void requestVerificationCode() async {
    if (formKey.currentState!.validate()) {
      String phoneNumber = phoneController.text;

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+82$phoneNumber', // 한국 국가 번호를 포함한 전화번호
        timeout: const Duration(minutes: 2),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          onError('인증 실패: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          onVerificationStateChanged(true);
          onVerificationIdReceived(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          onVerificationIdReceived(verificationId);
        },
      );
    }
  }

  void verifyCode(String verificationId) async {
    if (formKey.currentState!.validate()) {
      String smsCode = verificationCodeController.text;

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          UserRecord? existingUser = await userService.getUser(user.uid);

          if (existingUser == null) {
            UserRecord userRecord = UserRecord(
              uid: user.uid,
              phoneNumber: user.phoneNumber!,
              createdAt: DateTime.now(),
              addresses: [],
            );

            await userService.createUser(userRecord);
          }

          // 로그인 후 홈 페이지로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HelperHomeScreen()), // HomeScreen으로 이동
          );
        }
      } catch (e) {
        onError('인증번호가 올바르지 않습니다. 다시 시도해주세요.');
        print('인증 실패: $e');
      }
    }
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // 숫자 이외의 문자 제거
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');

    // 최대 11자리까지만 입력 허용
    final truncatedText = text.length > 11 ? text.substring(0, 11) : text;

    final buffer = StringBuffer();
    for (int i = 0; i < truncatedText.length; i++) {
      buffer.write(truncatedText[i]);
      if ((i == 2 || i == 6) && i != truncatedText.length - 1) {
        buffer.write('-'); // 하이픈 추가
      }
    }

    final newText = buffer.toString();
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CheckPhoneNumberValidate {
  String? validatePhoneNumber(FocusNode focusNode, String value) {
    final sanitizedValue = value.replaceAll('-', ''); // 하이픈 제거
    if (sanitizedValue.isEmpty) {
      focusNode.requestFocus();
      return '휴대폰 번호를 입력하세요.';
    } else {
      String pattern = r'^01[0-9]{8,9}$'; // 한국 휴대폰 번호 형식 정규식
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(sanitizedValue) || sanitizedValue.length != 11) {
        focusNode.requestFocus();
        return '11자리 숫자를 입력하세요.';
      } else {
        return null;
      }
    }
  }
}
