import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conveyance_apps/app/data/model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatServiceProvider extends GetConnect {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String receiverId, String message, String senderName) async {
    MessageModel newMessage = MessageModel(
      senderId: auth.currentUser!.uid,
      senderEmail: auth.currentUser!.email,
      senderName: senderName,
      receiverId: receiverId,
      message: message,
      timestamp: Timestamp.now(),
    );

    List<String> ids = [auth.currentUser!.uid, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(
          newMessage.toMap(),
        );
  }

  Stream<QuerySnapshot> getMessage(String receiverId, String senderId) {
    List<String> ids = [receiverId, senderId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
