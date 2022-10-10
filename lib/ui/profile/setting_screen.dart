import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instaflutter/ui/auth/welcome_screen.dart';
import 'package:instaflutter/utils/FirebaseHelper.dart';

import '../../model/User.dart';
import '../../utils/colors.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userModelProvider);
    return Scaffold(
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                dense: true,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                  );
                },
                title: const Text(
                  'ログアウト',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                dense: true,
                onTap: () async {
                  await FireStoreUtils.deleteUser();
                  currentUser.dispose();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                  );
                },
                title: const Text(
                  'アカウント削除',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }
}
