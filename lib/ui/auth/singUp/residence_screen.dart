import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/User.dart';
import '../../../utils/colors.dart';
import 'name_screen.dart';

class ResidenceScreen extends ConsumerStatefulWidget {
  const ResidenceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResidenceScreenState();
}

class _ResidenceScreenState extends ConsumerState<ResidenceScreen> {
  final List<String> fromList = [
    "選択",
    "北海道",
    "青森県",
    "岩手県",
    "宮城県",
    "秋田県",
    "山形県",
    "福島県",
    "茨城県",
    "栃木県",
    "群馬県",
    "埼玉県",
    "千葉県",
    "東京都",
    "神奈川県",
    "新潟県",
    "富山県",
    "石川県",
    "福井県",
    "山梨県",
    "長野県",
    "岐阜県",
    "静岡県",
    "愛知県",
    "三重県",
    "滋賀県",
    "京都府",
    "大阪府",
    "兵庫県",
    "奈良県",
    "和歌山県",
    "鳥取県",
    "島根県",
    "岡山県",
    "広島県",
    "山口県",
    "徳島県",
    "香川県",
    "愛媛県",
    "高知県",
    "福岡県",
    "佐賀県",
    "長崎県",
    "熊本県",
    "大分県",
    "宮崎県",
    "鹿児島県",
    "沖縄県",
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userModelProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: primaryColor),
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
                const Text(
                  '居住地',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(fromList[_currentIndex]),
                SizedBox(
                  height: 200,
                  child: CupertinoPicker(
                    itemExtent: 30,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    children: fromList.map((e) => Text(e)).toList(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 40.0, bottom: 60),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
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
                  ),
                ),
                onPressed: () {
                  currentUser.residence = fromList[_currentIndex];
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NameScreen()),
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
