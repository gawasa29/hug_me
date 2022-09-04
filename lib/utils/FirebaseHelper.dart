import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';

import '../constants.dart';
import '../model/User.dart';

class FireStoreUtils {
  //userの処理たち
  static Future<void> updateCurrentUser(User user) async {
    return await FirebaseFirestore.instance
        .collection(USERS)
        .doc(user.userID)
        .set(user.toJson());
  }

  static Future<User?> getCurrentUser(uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await FirebaseFirestore.instance.collection(USERS).doc(uid).get();
    if (userDocument.exists) {
      return User.fromJson(userDocument.data() ?? {});
    } else {
      return null;
    }
  }

  static deleteUser() async {
    // firestoreのuserを削除
    await FirebaseFirestore.instance
        .collection(USERS)
        .doc(auth.FirebaseAuth.instance.currentUser!.uid)
        .delete();
    //fireStoregeの写真を削除
    final storageRef = FirebaseStorage.instance.ref().child(
        'users/${auth.FirebaseAuth.instance.currentUser!.uid}/image.png');
    await storageRef.delete();
    // firebase authのuserを削除
    await auth.FirebaseAuth.instance.currentUser!.delete();
  }
}
