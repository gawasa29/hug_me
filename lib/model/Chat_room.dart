import 'User.dart';

class ChatRoom {
  String roomId;
  User? talkUser;
  String? lastMessage;

  ChatRoom({
    this.roomId = "",
    this.talkUser,
    this.lastMessage,
  });
}
