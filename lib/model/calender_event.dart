import 'dart:ui';

import 'package:equatable/equatable.dart';

class CalendarEvent extends Equatable with Comparable<CalendarEvent> {
  CalendarEvent({
    int? index,
    required this.dateTime,
    required this.title,
    this.desc = "",
    this.colorValue = 0,
    this.isPinned = false,
    this.isFavorited = false,
  }) : index = index ?? DateTime.now().millisecondsSinceEpoch;
  final int index;
  final DateTime dateTime;
  final String title;
  final String desc;
  final int colorValue;

  final bool isPinned;
  final bool isFavorited;

  Color get color => Color(colorValue);

  @override
  List<Object?> get props => [
        dateTime,
        title,
        desc,
        colorValue,
        isPinned,
        isFavorited,
      ];

  @override
  int compareTo(CalendarEvent other) {
    return dateTime.compareTo(other.dateTime);
  }

  CalendarEvent copyWith({
    int? index,
    DateTime? dateTime,
    String? title,
    String? desc,
    int? colorValue,
    bool? isPinned,
    bool? isFavorited,
  }) {
    return CalendarEvent(
      index: index ?? this.index,
      dateTime: dateTime ?? this.dateTime,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      colorValue: colorValue ?? this.colorValue,
      isPinned: isPinned ?? this.isPinned,
      isFavorited: isFavorited ?? this.isFavorited,
    );
  }
}
