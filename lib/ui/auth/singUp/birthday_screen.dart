import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../model/User.dart';
import '../../../utils/colors.dart';
import 'residence_screen.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  DateTime datetime = DateTime(2016, 10, 26);
  var formatter = DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP"); // DateからString
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

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
                        '生年月日',
                        style: TextStyle(
                          fontSize: 24,
                          color: primaryTextColor,
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
                        '8文字以内で入力してください。ニックネームは後から変更可能です。',
                        style: TextStyle(
                          fontSize: 15,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      DateFormat('yyyy/MM/dd').format(datetime),
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 30,
                        color: primaryTextColor,
                      ),
                    ),
                    onPressed: () {
                      _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: datetime,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          // This is called when the user changes the date.
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() => datetime = newDate);
                          },
                        ),
                      );
                    },
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
                    primary: primaryColor,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(color: primaryColor)),
                  ),
                  child: const Text(
                    '次',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    currentUser.birthday =
                        DateFormat('yyyy/MM/dd').format(datetime);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResidenceScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
