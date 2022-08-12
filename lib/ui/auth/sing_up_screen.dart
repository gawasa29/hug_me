import 'package:flutter/material.dart';

import 'start_screen.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({Key? key}) : super(key: key);

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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'メール',
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 83, 83, 83),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextFormField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.green[300],
              ),
              labelText: 'メールアドレス',
              floatingLabelStyle: const TextStyle(fontSize: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.green[100]!,
                  width: 1.0,
                ),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.green[300],
              ),
              labelText: 'パスワード',
              floatingLabelStyle: const TextStyle(fontSize: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.green[100]!,
                  width: 1.0,
                ),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.green[300],
              ),
              labelText: 'パスワード確認',
              floatingLabelStyle: const TextStyle(fontSize: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.green[100]!,
                  width: 1.0,
                ),
              ),
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
                  ),
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
                        builder: (context) => const StartScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
