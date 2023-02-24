import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class WDatePicker {
  static Future<DateTime?> picker(
    BuildContext context, {
    DateTime? currentTime,
  }) {
    return DatePicker.showDatePicker(
      context,
      locale: LocaleType.ko,
      currentTime: currentTime,
    );
  }
}
