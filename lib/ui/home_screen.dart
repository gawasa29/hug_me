import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('firebaseテスト'),
      ),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> data = <String, dynamic>{
            'name': "sample",
          };
          await FirebaseFirestore.instance.collection('sample').doc().set(data);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
