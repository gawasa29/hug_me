import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: const <Widget>[Text("chat")],
          ),
        ));
  }
}
