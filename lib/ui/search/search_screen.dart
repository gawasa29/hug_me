import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instaflutter/model/User.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userModelProvider);
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 250,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                print(index);
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1491349174775-aaafddd81942?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8MTB8fHBlcnNvbnxlbnwwfHx8fDE2NjUxNTA1MzA&ixlib=rb-1.2.1&q=80&w=400'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      textAlign: TextAlign.left,
                      "愛知県 20歳",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 83, 83, 83),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      textAlign: TextAlign.left,
                      "はなこ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 83, 83, 83),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
