import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instaflutter/ui/home_screen.dart';

import 'firebase_options.dart';

//現時点では目標設定画面
Future<void> main() async {
  //おまじない
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
//flutterfire_cliで追加されたfirebase_options.dartのためにいる。
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
