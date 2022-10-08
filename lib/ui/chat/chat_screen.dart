import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/Chat_room.dart';
import '../../utils/FirebaseHelper.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      return ListView.builder(
                        itemCount: chatRooms.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              print(chatRooms[index].roomId);
                            },
                            child: SizedBox(
                              height: 70,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: chatRooms[index]
                                                  .talkUser
                                                  .profilePictureURL ==
                                              null
                                          ? const AssetImage(
                                              'assets/images/placeholder.png')
                                          : NetworkImage(chatRooms[index]
                                                  .talkUser
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
                                        chatRooms[index].talkUser.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
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
