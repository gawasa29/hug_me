import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/User.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  @override
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
                child: currentUser.profilePictureURL == null
                    ? Image.asset('assets/images/placeholder.png')
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          currentUser.profilePictureURL,
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
