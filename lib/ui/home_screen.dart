import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/User.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String? imageUrl;
  const HomeScreen(this.imageUrl, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late String? imageUrl;
  @override
  void initState() {
    super.initState();

    // 受け取ったデータを状態を管理する変数に格納
    imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userModelProvider);
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
        body: Center(
          child: Column(
            children: <Widget>[
              const Text(
                'テスト',
                style: TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 83, 83, 83),
                ),
              ),
              Center(
                child: imageUrl == null
                    ? Image.asset('assets/images/placeholder.png')
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          imageUrl!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        )),
              ),
              Text(currentUser.name),
              Text(currentUser.birthday),
              Text(currentUser.bio),
              Text(currentUser.residence),
            ],
          ),
        ));
  }
}
