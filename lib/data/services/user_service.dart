import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_record.dart';

class UserService {
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  // 유저 생성 메서드
  Future<void> createUser(UserRecord userRecord) async {
    try {
      final DocumentSnapshot userDoc =
      await _usersCollection.doc(userRecord.uid).get();

      if (userDoc.exists) {
        // 유저가 이미 존재하면 새로운 유저 생성하지 않음
      } else {
        // 유저가 존재하지 않으면 새로 생성
        await _usersCollection.doc(userRecord.uid).set(userRecord.toMap());
      }
    } catch (e) {
      throw Exception('Error creating user');
    }
  }

  // 유저 정보 가져오기 메서드
  Future<UserRecord?> getUser(String uid) async {
    try {
      final DocumentSnapshot userDoc = await _usersCollection.doc(uid).get();

      if (userDoc.exists) {
        return UserRecord.fromMap(userDoc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user');
    }
  }
}