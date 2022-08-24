import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chat/chat_screen.dart';
import 'profile/profile_screen.dart';
import 'search/search_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var _navIndex = 0;

  late Widget _currentWidget;
  @override
  void initState() {
    _currentWidget = const SearchScreen();
    super.initState();
  }

  //!数字で画面きりかえの仕組み
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        _currentWidget = const SearchScreen();
      } else if (_selectedIndex == 1) {
        _currentWidget = const ChatScreen();
      } else if (_selectedIndex == 2) {
        _currentWidget = const ProfileScreen();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: ('探す'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: ('チャット'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: ('マイページ'),
          ),
        ],
        onTap: (int index) {
          setState(
            () {
              _navIndex = index;
              _onItemTapped(index);
            },
          );
        },
        currentIndex: _navIndex,
        backgroundColor: const Color.fromARGB(255, 97, 201, 196),
        iconSize: 40,
      ),
      body: SafeArea(child: _currentWidget),
    );
  }
}
