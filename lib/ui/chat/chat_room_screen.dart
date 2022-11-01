import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaflutter/utils/colors.dart';
import 'package:intl/intl.dart' as intl;
import 'package:uuid/uuid.dart';

import '../../model/Chat_room.dart';
import '../../model/Message.dart';
import '../../utils/FirebaseHelper.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final ChatRoom chatRoom;
  const ChatRoomScreen(this.chatRoom, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final TextEditingController controller = TextEditingController();

  roomUploadPic() async {
    try {
      /// 画像を選択
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      File file = File(image!.path);

      //ランダムなIDを代入
      String uploadName = Uuid().v1();
      //参照を作成
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('room/${widget.chatRoom.roomId}/$uploadName');
      // Firebase Cloud Storageにアップロード
      await storageRef.putFile(file);

      String imageUrl = await storageRef.getDownloadURL();
      FirebaseFirestore.instance
          .collection("room")
          .doc(widget.chatRoom.roomId)
          .collection('message')
          .doc(uploadName)
          .set({
        'type': 'ima',
        'message': imageUrl,
        'sender_id': auth.FirebaseAuth.instance.currentUser!.uid,
        'send_time': Timestamp.now()
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 228, 249, 247),
          appBar: AppBar(
            title: Text(widget.chatRoom.talkUser!.name),
            backgroundColor: primaryColor,
            elevation: 0,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FireStoreUtils.fetchMessageSnapshot(
                      widget.chatRoom.roomId),
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
                                  sendTime: data['send_time'],
                                  type: data['type']);
                              return message.type == 'text'
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                          bottom: index == 0 ? 20 : 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        textDirection: message.isMe
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                        children: [
                                          Container(
                                              //テキストが長かったら折り返しする処理
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.6),
                                              decoration: BoxDecoration(
                                                  color: message.isMe
                                                      ? primaryColor
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                              child: Text(message.message)),
                                          Text(intl.DateFormat("HH:mm").format(
                                              message.sendTime.toDate()))
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      alignment: message.isMe == true
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Image.network(message.message),
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
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.image,
                            color: primaryColor,
                          ),
                          onPressed: () async {
                            roomUploadPic();
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              controller: controller,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: "メッセージを入力",
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.paperPlane,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            if (controller.text != '') {
                              FireStoreUtils.sendMessage(
                                  roomId: widget.chatRoom.roomId,
                                  message: controller.text);
                              controller.clear();
                            }
                          },
                        ),
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
          )),
    );
  }
}
