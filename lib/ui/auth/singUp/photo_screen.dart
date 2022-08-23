import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaflutter/constants.dart';
import 'package:instaflutter/ui/home_screen.dart';

import '../../../model/User.dart';
import '../../../utils/FirebaseHelper.dart';

class PhotoScreen extends ConsumerStatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends ConsumerState<PhotoScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userModelProvider);
    uploadPic() async {
      try {
        /// 画像を選択
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        File file = File(image!.path);

        //参照を作成
        String uploadName = 'image.png';
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('users/${currentUser.userID}/$uploadName');
        // Firebase Cloud Storageにアップロード
        final task = await storageRef.putFile(file);
      } catch (e) {
        print(e);
      }
    }

    downloadPic() async {
      try {
        /// 参照の作成
        String downloadName = 'image.png';
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('users/${currentUser.userID}/$downloadName');

        currentUser.profilePictureURL = await storageRef.getDownloadURL();
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white10,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          children: <Widget>[
            const Text(
              '写真を登録しましょう',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 83, 83, 83),
              ),
            ),
            const Text(
              '写真を登録するとマッチング率がアップします。',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 83, 83, 83),
              ),
            ),
            Center(
              child: currentUser.profilePictureURL == ''
                  ? Image.asset('assets/images/placeholder.png')
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        currentUser.profilePictureURL,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 97, 201, 196),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(color: Color(mainColor))),
                  ),
                  child: const Text(
                    '写真をアップロード',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFAFAFA),
                    ),
                  ),
                  onPressed: () async {
                    await uploadPic();
                    await downloadPic();
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 97, 201, 196),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(color: Color(mainColor))),
                  ),
                  child: const Text(
                    '次',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFAFAFA),
                    ),
                  ),
                  onPressed: () async {
                    //firestoreに値を更新
                    await FireStoreUtils.updateCurrentUser(currentUser);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
