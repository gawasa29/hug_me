import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100) //角の丸み
                ),
            title: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.list),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: '検索',
                    border: InputBorder.none),
              ),
            )),
        body: Center(
          child: Column(
            children: const <Widget>[Text("search")],
          ),
        ));
  }
}
