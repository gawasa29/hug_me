import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instaflutter/utils/colors.dart';

import '../../model/Chat_room.dart';
import '../../utils/FirebaseHelper.dart';
import 'chat_room_screen.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          "トーク",
          style: TextStyle(color: primaryTextColor),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FireStoreUtils.joindRoomSnapshot,
          //streamSnapshotとfutereSnapshotはややこしくなるから変数名変えてるだけ本来はsnapshotだけ。
          builder: (context, streamSnapshot) {
            //データがあったらの処理
            if (streamSnapshot.hasData) {
              return FutureBuilder<List<ChatRoom>?>(
                  future: FireStoreUtils.fetchMyRoom(streamSnapshot.data!),
                  builder: (context, futereSnapshot) {
                    if (futereSnapshot.hasData) {
                      List<ChatRoom> chatRooms = futereSnapshot.data!;
                      print(chatRooms);
                      return ListView.builder(
                        itemCount: chatRooms.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChatRoomScreen(chatRooms[index])),
                              );
                            },
                            child: SizedBox(
                              height: 90,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: chatRooms[index]
                                                  .talkUser!
                                                  .profilePictureURL ==
                                              null
                                          ? const AssetImage(
                                              'assets/images/placeholder.png')
                                          : NetworkImage(chatRooms[index]
                                                  .talkUser!
                                                  .profilePictureURL)
                                              as ImageProvider,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        chatRooms[index].talkUser!.name,
                                        style: const TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        chatRooms[index].lastMessage ?? '',
                                        style: const TextStyle(
                                            color: secondaryTextColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  });
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
