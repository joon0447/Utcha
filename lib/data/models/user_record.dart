import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecord {
  final String uid;
  final String phoneNumber;
  final String? displayName; //닉네임
  final DateTime createdAt;
  final List<Map<String, dynamic>> addresses;
  final String profileUrl;
  final String? selfIntroduction; //자기소개

  UserRecord({
    required this.uid,
    required this.phoneNumber,
    this.displayName,
    required this.createdAt,
    required this.addresses,
    this.profileUrl = 'https://firebasestorage.googleapis.com/v0/b/utcha-7d76e.appspot.com/o/user_profile%2Fprofile.png?alt=media&token=a1f4f763-a467-4c0c-8e93-8e88f0f9c848',
    this.selfIntroduction,
  });

  factory UserRecord.fromMap(Map<String, dynamic> map) {
    return UserRecord(
      uid: map['uid'] as String,
      phoneNumber: map['phoneNumber'] as String,
      displayName: map['displayName'] as String?,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      addresses: List<Map<String, dynamic>>.from(map['addresses'] ?? []),
      profileUrl: map['profileUrl'] as String,
      selfIntroduction: map['selfIntroduction'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'createdAt': createdAt,
      'addresses': addresses,
      'profileUrl': profileUrl,
      'selfIntroduction' : selfIntroduction,
    };
  }
}
