import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conveyance_apps/app/data/providers/chat_service_provider.dart';
import 'package:conveyance_apps/app/data/providers/firebase_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final messageCtrl = TextEditingController();
  final chatService = ChatServiceProvider();
  final authService = FirebaseServiceProvider();

  Future<void> sendMessage(String receiverId) async {
    final docRef = await authService.db
        .collection('users')
        .doc(authService.auth.currentUser!.uid)
        .get();

    await chatService.sendMessage(
        receiverId, messageCtrl.text, docRef.data()!['name']);
    messageCtrl.clear();
  }

  Stream<QuerySnapshot> getMessage(String receiverId, String senderId) {
    return chatService.getMessage(receiverId, senderId);
  }
}
