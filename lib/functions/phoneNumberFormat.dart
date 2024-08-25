// ignore: file_names
String formatPhoneNum(String phoneNumber) {
    // 전화번호 01012345678 -> 010-1234-5678 변환
    return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}';
  }