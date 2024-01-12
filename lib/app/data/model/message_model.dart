import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? senderId;
  final String? senderEmail;
  final String? senderName;
  final String? receiverId;
  final String? message;
  final Timestamp? timestamp;

  MessageModel({
    this.senderId,
    this.senderEmail,
    this.senderName,
    this.receiverId,
    this.message,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'senderName': senderName,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp
    };
  }
}
