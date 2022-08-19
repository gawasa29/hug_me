import 'package:flutter/material.dart';
import 'package:instaflutter/constants.dart';

import 'registered_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isChecked = false;
  bool isChecked2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white10,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        textAlign: TextAlign.left,
                        'さあ、始めましょう！',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 83, 83, 83),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Hug me!はハグする相手を見つけられる\nマッチングアプリです。',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 191, 191, 191),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 40.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  '利用規約及びコミュニティガイドライン、\nプライバシーポリシーへの同意が必要となります。',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 191, 191, 191),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),
                const Text(
                  '私は女性です',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Checkbox(
                    value: isChecked2,
                    onChanged: (value) {
                      setState(() {
                        isChecked2 = value!;
                      });
                    },
                  ),
                ),
                const Text(
                  '全ての規約に同意します',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
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
                    '登録する',
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
                          builder: (context) => const RegisteredScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
