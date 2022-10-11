import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/colors.dart';
import 'otp_screen.dart';

class SingUpScreen extends ConsumerStatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends ConsumerState<SingUpScreen> {
  @override
  Widget build(BuildContext context) {
    String phone = '';
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                    '電話番号',
                    style: TextStyle(
                      fontSize: 24,
                      color: primaryTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                        ),
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                        labelText: '電話番号',
                        floatingLabelStyle: const TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: primaryColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      onChanged: (String? val) {
                        phone = "+81${val!}";
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
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("コードをこの番号に送信します"),
                          content: Text(phone),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtpScreen(phone)),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
