import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:utcha/data/models/chat_member.dart';

class ChatRoom {
  String chatRoomId;
  ChatMember writer;
  ChatMember contact;
  List<Message> messages;
  ChatRoom(
      {required this.chatRoomId,
      required this.writer,
      required this.contact,
      required this.messages});
}
