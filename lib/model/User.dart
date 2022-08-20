import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//StateProviderは外部から変更可能な値を公開できるProvider
final userModelProvider = StateProvider((ref) {
  return User();
});

class User with ChangeNotifier {
  String userID;

  String name;

  String bio;

  String birthday;

  String residence;

  User({
    this.userID = "",
    this.name = "",
    this.bio = "",
    this.birthday = "",
    this.residence = "",
  });

  //Firebaseからデータを取得する際の変換処理
  User.fromJson(Map<String, dynamic> json)
      : this(
          userID: json['userID'],
          name: json['name'],
          bio: json['bio'],
          birthday: json['birthday'],
          residence: json['residence'],
        );

  //DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      "name": name,
      'bio': bio,
      'birthday': birthday,
      'residence': residence,
    };
  }
}
