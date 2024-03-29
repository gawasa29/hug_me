import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
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
          backgroundColor: appBarColor,
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
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: primaryTextColor,
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
                          color: secondaryTextColor,
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
                    color: secondaryTextColor,
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
                TextButton(
                  child: const Text(
                    '私は女性です',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onPressed: () {
                    if (isChecked) {
                      isChecked = false;
                    } else {
                      isChecked = true;
                    }
                    setState(() {});
                  },
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
                TextButton(
                  child: const Text(
                    '全ての規約に同意します',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onPressed: () {
                    if (isChecked2) {
                      isChecked2 = false;
                    } else {
                      isChecked2 = true;
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 40.0, left: 40.0, bottom: 60),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //三項演算子で色変える
                      primary: (isChecked && isChecked2)
                          ? primaryColor
                          : Colors.blueAccent,
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      '次へ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //三項演算子でisCheckedとisChecked2がどっちもtrueでボタン押せる
                    onPressed: (isChecked && isChecked2)
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisteredScreen()),
                            );
                          }
                        : null),
              ),
            ),
          ],
        ));
  }
}
