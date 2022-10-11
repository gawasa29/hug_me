import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instaflutter/model/User.dart';

import '../../utils/FirebaseHelper.dart';
import '../../utils/colors.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userModelProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>?>(
            future: FireStoreUtils.fetchUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data();
                    return Card(
                      child: InkWell(
                        onTap: () {
                          FireStoreUtils.createRoom(
                              data['userID'], currentUser.userID);
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage(data['profilePictureURL']),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                textAlign: TextAlign.left,
                                "愛知県 20歳",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: primaryTextColor,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data['name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: primaryTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
