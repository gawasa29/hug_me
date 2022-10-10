import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;

import '../../model/Chat_room.dart';
import '../../model/Message.dart';
import '../../utils/FirebaseHelper.dart';
import '../../utils/colors.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final ChatRoom chatRoom;
  const ChatRoomScreen(this.chatRoom, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Text(widget.chatRoom.talkUser!.name),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: appBarColor),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream:
                    FireStoreUtils.fetchMessageSnapshot(widget.chatRoom.roomId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: ListView.builder(
                          physics: const RangeMaintainingScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final doc = snapshot.data!.docs[index];
                            //オブジェクト型をMap型に変更
                            final Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            Message message = Message(
                                message: data['message'],
                                isMe: auth.FirebaseAuth.instance.currentUser!
                                        .uid ==
                                    data['sender_id'],
                                sendTime: data['send_time']);
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                  bottom: index == 0 ? 20 : 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                textDirection: message.isMe
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  Container(
                                      //テキストが長かったら折り返しする処理
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6),
                                      decoration: BoxDecoration(
                                          color: message.isMe
                                              ? Colors.green
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: Text(message.message)),
                                  Text(intl.DateFormat("HH:mm")
                                      .format(message.sendTime.toDate()))
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Center(
                      child: Text('メッセージがありません'),
                    );
                  }
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            FireStoreUtils.sendMessage(
                                roomId: widget.chatRoom.roomId,
                                message: controller.text);
                            controller.clear();
                          },
                          icon: const Icon(Icons.send))
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            )
          ],
        ));
  }
}
