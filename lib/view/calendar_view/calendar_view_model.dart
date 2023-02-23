import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wurigiri/controller/calendar_controller.dart';
import 'package:wurigiri/model/calender_event.dart';

class CalendarViewModel {
  final calendarController = CalendarController.find();
  final List<CalendarEvent> eventList = [];

  void init() {
    eventList.addAll(
      List.generate(
        20,
        (index) => CalendarEvent(
          index: index,
          dateTime: DateTime.now().add(Duration(days: index)),
          title: "TestTitle $index",
        ),
      ),
    );
    eventList.sort();
  }

  void updateEvent(CalendarEvent event) {
    final listIndex =
        eventList.indexWhere((element) => element.index == event.index);

    if (listIndex == -1) {
      eventList.add(event);
    } else {
      eventList[listIndex] = event;
    }

    calendarController.updateEvent(event);
    Future.delayed(const Duration(milliseconds: 300)).then(
      (value) {
        calendarController.update();
      },
    );
  }

  void removeEvent(CalendarEvent event) async {
    final listIndex =
        eventList.indexWhere((element) => element.index == event.index);
    if (listIndex == -1) {
      return;
    } else {
      eventList.removeAt(listIndex);
    }
    calendarController.removeEvent(event);
    calendarController.update();
  }

  final ValueNotifier<DateTime> focustDayNotifier =
      ValueNotifier(DateTime.now());

  void onTapCalendarDay(DateTime dateTime) {
    focustDayNotifier.value = dateTime;
    final list = eventList.where(
      (e) => isSameDay(e.dateTime, dateTime),
    );
    if (list.isEmpty) {
      return;
    }
    scrollToEvent(list.first);
  }

  final Map<int, GlobalKey> _eventKeyMap = {};

  GlobalKey eventKey(CalendarEvent event) {
    if (_eventKeyMap[event.index] == null) {
      final key = GlobalKey();
      _eventKeyMap[event.index] = key;
    }
    return _eventKeyMap[event.index]!;
  }

  void scrollToEvent(CalendarEvent event) {
    final key = _eventKeyMap[event.index];
    if (key == null) {
      return;
    }
    final context = key.currentContext;
    if (context == null) {
      return;
    }
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 300),
      alignment: 0.0,
    );
  }
}
