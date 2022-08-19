import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/User.dart';
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
                        fontSize: 24,
                        color: Color.fromARGB(255, 83, 83, 83),
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
                        color: Color.fromARGB(255, 191, 191, 191),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 70),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'Momo'),
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
                const EdgeInsets.only(right: 40.0, left: 40.0, bottom: 100),
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
                        builder: (context) => const SingUpScreen()),
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
