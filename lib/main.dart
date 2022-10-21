import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instaflutter/model/User.dart';
import 'package:instaflutter/ui/auth/welcome_screen.dart';
import 'package:instaflutter/ui/home_screen.dart';

import 'firebase_options.dart';
import 'utils/FirebaseHelper.dart';

//現時点では目標設定画面
Future<void> main() async {
  //おまじない
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
//flutterfire_cliで追加されたfirebase_options.dartのためにいる。
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // トークンの取得
  final token = await messaging.getToken();
  print('🐯 FCM TOKEN: $token');

  return runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Represents the MyApp class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //flutter_localizationsを使って日本語化
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
      ],
      locale: const Locale('ja'),

      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthStatusCheck(),
    );
  }
}

class AuthStatusCheck extends ConsumerWidget {
  const AuthStatusCheck({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //値更新用のuserクラス
    final user = ref.watch(userModelProvider.notifier);

    modelSet() async {
      //これでfirestoreから持ってきた値をUserクラスに代入し直す
      user.state = (await FireStoreUtils.getCurrentUser(
          FirebaseAuth.instance.currentUser!.uid))!;
    }

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // スプラッシュ画面などに書き換えても良い
          return const SizedBox();
        }
        if (snapshot.hasData) {
          // User が null でなない、つまりサインイン済みのホーム画面へ
          modelSet();
          return const HomeScreen();
        }
        // User が null である、つまり未サインインのサインイン画面へ
        return const WelcomeScreen();
      },
    );
  }
}
