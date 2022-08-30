import 'package:intl/intl.dart';

ageCalculation(birthday) {
  DateTime dateTime = DateFormat('y/M/d').parse(birthday);
  final today = DateTime.now();
  //年齢算出
  var age = today.year - dateTime.year;
  //誕生日が来てなかったらマイナス１する
  if (today.month < dateTime.month) {
    return age - 1;
  }
}
