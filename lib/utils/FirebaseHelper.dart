import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';

import '../constants.dart';
import '../model/Chat_room.dart';
import '../model/User.dart';

class FireStoreUtils {
  static final joindRoomSnapshot = FirebaseFirestore.instance
      .collection("room")
      .where("joined_user_ids",
          arrayContains: auth.FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

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

  //自分以外のuserを抽出
  static Future<QuerySnapshot<Map<String, dynamic>>?> fetchUsers() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("userID", whereNotIn: [
      auth.FirebaseAuth.instance.currentUser!.uid,
    ]).get();
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

//roomの処理
  static Future<void> createRoom(String uid, myUid) async {
    await FirebaseFirestore.instance.collection('room').add({
      "joined_user_ids": [uid, myUid],
      "created_time": Timestamp.now()
    });
  }

  static Future<List<ChatRoom>?> fetchMyRoom(QuerySnapshot snapshot) async {
    List<ChatRoom> talkRooms = [];
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<dynamic> userIds = data['joined_user_ids'];
      late String? talkUserUid;
      for (var id in userIds) {
        if (id == auth.FirebaseAuth.instance.currentUser!.uid) continue;
        talkUserUid = id;
      }
      User? talkUser = await getCurrentUser(talkUserUid);
      if (talkUser == null) return null;
      final talkRoom = ChatRoom(
          roomId: doc.id,
          talkUser: talkUser,
          lastMessage: data['last_message']);
      talkRooms.add(talkRoom);
    }

    return talkRooms;
  }

  static Stream<QuerySnapshot> fetchMessageSnapshot(String roomId) {
    return FirebaseFirestore.instance
        .collection("room")
        .doc(roomId)
        .collection('message')
        //orderBy（特定の条件で並べ替える）チャットのメッセージを時間ごとで表示したいから並び替えるorderByを使っている。
        .orderBy('send_time', descending: true)
        .snapshots();
  }

  static Future<void> sendMessage(
      {required String roomId, required String message}) async {
    final messageCollection = FirebaseFirestore.instance
        .collection("room")
        .doc(roomId)
        .collection('message');

    await messageCollection.add({
      'message': message,
      'sender_id': auth.FirebaseAuth.instance.currentUser!.uid,
      'send_time': Timestamp.now()
    });
    FirebaseFirestore.instance
        .collection("room")
        .doc(roomId)
        .update({'last_message': message});
  }
}
