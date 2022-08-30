import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaflutter/constants.dart';

import '../../model/User.dart';
import '../../utils/helper.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userModelProvider);
    var age = ageCalculation(currentUser.birthday);
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
          automaticallyImplyLeading: false,
          //ちょい透かし
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0,
          actions: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                color: const Color.fromARGB(255, 83, 83, 83),
                icon: const Icon(
                  Icons.settings,
                  size: 35,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Text(
              currentUser.name,
              style: const TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 83, 83, 83),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Center(
                    child: currentUser.profilePictureURL == null
                        ? Image.asset('assets/images/placeholder.png')
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(130),
                            child: Image.network(
                              currentUser.profilePictureURL,
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                            )),
                  ),
                  Positioned(
                    left: 80,
                    right: 0,
                    child: FloatingActionButton(
                      heroTag: 'pickImage',
                      backgroundColor: const Color(mainColor),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Color(0xffFAFAFA),
                      ),
                      mini: true,
                      onPressed: () async {
                        await uploadPic();
                        await downloadPic();
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 31,
                  ),
                  child: const Text("年齢",
                      style:
                          TextStyle(fontSize: 20, color: Color(COLOR_PRIMARY))),
                ),
                Container(
                    padding: const EdgeInsets.only(
                      right: 31,
                    ),
                    child: Text(age.toString(),
                        style: const TextStyle(
                            fontSize: 20, color: Color(COLOR_PRIMARY))))
              ],
            ),
            const Divider(
              color: Colors.black,
              height: 30,
              thickness: 0.5,
              indent: 30,
              endIndent: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 31),
                  child: const Text("居住地",
                      style:
                          TextStyle(fontSize: 20, color: Color(COLOR_PRIMARY))),
                ),
                Container(
                    padding: const EdgeInsets.only(right: 31),
                    child: Text(currentUser.residence,
                        style: const TextStyle(
                            fontSize: 20, color: Color(COLOR_PRIMARY))))
              ],
            ),
            const Divider(
              color: Colors.black,
              height: 30,
              thickness: 0.5,
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextFormField(
                maxLines: 6,
                minLines: 6,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: currentUser.bio,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                ),
                onChanged: (String? val) {
                  currentUser.bio = val!;
                },
              ),
            ),
          ],
        ));
  }
}
