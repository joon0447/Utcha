import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MypageController {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController selfIntroductionController = TextEditingController();
  final ValueNotifier<String> profileImageUrl = ValueNotifier<String>(
      'https://firebasestorage.googleapis.com/v0/b/utcha-7d76e.appspot.com/o/user_profile%2Fprofile.png?alt=media&token=a1f4f763-a467-4c0c-8e93-8e88f0f9c848');

  bool isNicknameValid = false;
  bool isSelfIntroductionValid = false;

  Future<void> loadUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      profileImageUrl.value =
          userDoc['profileUrl'] as String? ?? profileImageUrl.value;
      nicknameController.text = userDoc['displayName'] as String? ?? '';
      isNicknameValid = validateNickname(nicknameController.text);

      selfIntroductionController.text = userDoc['selfIntroduction'] as String? ?? '';
      isSelfIntroductionValid = validateNickname(selfIntroductionController.text);
    }
  }

  bool validateNickname(String name) {
    if (name.length >= 2 && name.length <= 6) {
      String pattern = r'^[가-힣0-9]+$';
      RegExp regex = RegExp(pattern);
      return regex.hasMatch(name);
    } else {
      return false;
    }
  }

  Future<void> saveNickname(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && isNicknameValid) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'displayName': nicknameController.text,
      });
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      String imageUrl = await _uploadImageToStorage(image);
      await _updateProfileImageUrl(imageUrl);
    }
  }

  Future<String> _uploadImageToStorage(XFile image) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Reference storageRef =
      FirebaseStorage.instance.ref().child('user_profile/${user.uid}');
      await storageRef.putFile(File(image.path));
      return await storageRef.getDownloadURL();
    }
    return '';
  }

  Future<void> _updateProfileImageUrl(String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'profileUrl': imageUrl,
      });
      profileImageUrl.value = imageUrl;
    }
  }

  Future<void> deleteProfileImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Reference storageRef =
      FirebaseStorage.instance.ref().child('user_profile/${user.uid}');
      await storageRef.delete();

      const String defaultImageUrl =
          'https://firebasestorage.googleapis.com/v0/b/utcha-7d76e.appspot.com/o/user_profile%2Fprofile.png?alt=media&token=a1f4f763-a467-4c0c-8e93-8e88f0f9c848';

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'profileUrl': defaultImageUrl,
      });

      profileImageUrl.value = defaultImageUrl;
    }
  }

  bool validateSelfIntroduction(String SelfIntroduction) {
    if (SelfIntroduction.length <= 100) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveSelfIntroduction(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && isSelfIntroductionValid) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'selfIntroduction': selfIntroductionController.text,
      });
    }
  }
}