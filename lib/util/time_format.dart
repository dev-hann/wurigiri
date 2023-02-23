import 'package:intl/intl.dart';

class WTimeFormat {
  WTimeFormat(this.dateTime);
  final DateTime dateTime;

  String get dateFormat => DateFormat("yyyy-mm-dd").format(dateTime);

  int calculateDay() {
    final now = DateTime.now();
    final nowDateTime = DateTime(now.year, now.month, now.day);
    final other = DateTime(dateTime.year, dateTime.month, dateTime.day);
    return other.difference(nowDateTime).inDays;
  }
}
