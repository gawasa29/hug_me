import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instaflutter/constants.dart';

import '../../../model/User.dart';
import '../../../utils/FirebaseHelper.dart';
import 'bio_screen.dart';

class RegisteredScreen extends ConsumerStatefulWidget {
  const RegisteredScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisteredScreenState();
}

class _RegisteredScreenState extends ConsumerState<RegisteredScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userModelProvider);
    //値更新用のuserクラス
    final user = ref.watch(userModelProvider.notifier);
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
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        textAlign: TextAlign.left,
                        '登録',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 83, 83, 83),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'これからあなたに合った相手を見つける\nために、プロフィールを完成させましょう\n全て登録するとより多くの相手と出会う\nことができます。',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 191, 191, 191),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset('assets//images/hug_photo.png'),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 40.0, left: 40.0, bottom: 100),
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
                    'アカウントを登録',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFAFAFA),
                    ),
                  ),
                  onPressed: () async {
                    //UserModelのuserIDメンバ変数に現在ログインしているユーザーのUIDを代入
                    currentUser.userID = FirebaseAuth.instance.currentUser!.uid;
                    await FireStoreUtils.updateCurrentUser(currentUser);
                    //これでfirestoreから持ってきた値をUserクラスに代入し直す
                    user.state = (await FireStoreUtils.getCurrentUser(
                        FirebaseAuth.instance.currentUser!.uid))!;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BioScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
