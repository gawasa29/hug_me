import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/User.dart';
import '../../../utils/colors.dart';
import 'sing_up_screen.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userModelProvider);
    //画面タップした時にキーボード非表示にする処理
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: primaryColor),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
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
                        'ニックネーム',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: primaryTextColor,
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
                        '8文字以内で入力してください。\nニックネームは後から変更可能です。',
                        style: TextStyle(
                          fontSize: 15,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 70),
                    child: TextFormField(
                      cursorColor: primaryColor,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        hintText: '例:Momo',
                      ),
                      onChanged: (String? val) {
                        currentUser.name = val!;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 40.0, left: 40.0, bottom: 60),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    '次',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SingUpScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
