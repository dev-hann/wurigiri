import 'package:intl/intl.dart';

class WTimeFormat {
  WTimeFormat(this.dateTime);
  final DateTime dateTime;

  String get dateFormat => DateFormat("yyyy-mm-dd").format(dateTime);
}
