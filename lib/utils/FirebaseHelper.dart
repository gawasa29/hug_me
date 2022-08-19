import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

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
}
