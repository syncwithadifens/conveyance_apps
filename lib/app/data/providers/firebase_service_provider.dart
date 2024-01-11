import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class FirebaseServiceProvider extends GetConnect {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  String? avatar;
  // @override
  // void onInit() {
  //   httpClient.baseUrl = 'YOUR-API-URL';
  // }

  Future<User?> signUpWithEmail(
      String email, String password, String name, XFile? profilePhoto) async {
    try {
      // NOTE: firebase authentication with email
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // NOTE: upload image to storage
      if (profilePhoto != null && userCredential.user != null) {
        await storage
            .ref()
            .child('profile_photo')
            .child(userCredential.user!.uid + path.extension(profilePhoto.path))
            .putFile(File(profilePhoto.path));

        avatar = await storage
            .ref()
            .child('profile_photo')
            .child(userCredential.user!.uid + path.extension(profilePhoto.path))
            .getDownloadURL();
      }

      // NOTE: add user to database
      await db.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': userCredential.user!.email,
        'profile_photo': avatar
      });

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
