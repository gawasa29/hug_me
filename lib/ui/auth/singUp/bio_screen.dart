import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/User.dart';
import '../../../utils/FirebaseHelper.dart';
import '../../../utils/colors.dart';
import 'photo_screen.dart';

class BioScreen extends ConsumerWidget {
  const BioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userModelProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
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
                        'プロフィールを入力しましょう',
                        style: TextStyle(
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
                        'あなたの趣味や興味のあることを入力しましょう。後からでも変更できます。',
                        style: TextStyle(
                          fontSize: 15,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextFormField(
                      maxLines: 6,
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: '初めまして！',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(
                            width: 2,
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(
                            width: 2,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      onChanged: (String? val) {
                        currentUser.bio = val!;
                      },
                    ),
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
                    primary: primaryColor,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(color: primaryColor)),
                  ),
                  child: const Text(
                    '次',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await FireStoreUtils.updateCurrentUser(currentUser);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhotoScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
