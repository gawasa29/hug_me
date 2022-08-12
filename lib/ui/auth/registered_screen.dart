import 'package:flutter/material.dart';
import 'package:instaflutter/constants.dart';

import 'bio_screen.dart';

class RegisteredScreen extends StatefulWidget {
  const RegisteredScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredScreen> createState() => _RegisteredScreenState();
}

class _RegisteredScreenState extends State<RegisteredScreen> {
  @override
  Widget build(BuildContext context) {
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
              '登録が完了しました！',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 83, 83, 83),
              ),
            ),
            const Text(
              'これからあなたに合った相手を見つけるために、プロフィールを完成させましょう全て登録するとより多くの相手と出会うことができます。',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 83, 83, 83),
              ),
            ),
            const Text(
              '利用規約及びコミュニティガイドライン、プライバシーポリシーへの同意が必要となります。',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 83, 83, 83),
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
                  onPressed: () {
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
