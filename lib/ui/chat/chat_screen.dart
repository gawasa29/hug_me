import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white10,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: const <Widget>[Text("chat")],
          ),
        ));
  }
}
