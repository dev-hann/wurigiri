library calendar_view;

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:wurigiri/consts/const.dart';
import 'package:wurigiri/controller/calendar_controller.dart';
import 'package:wurigiri/model/calender_event.dart';
import 'package:wurigiri/util/time_format.dart';
import 'package:wurigiri/view/calendar_view/calendar_view_model.dart';
import 'package:wurigiri/widget/title.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:badges/badges.dart' as badges;

part './event_edit_view/event_edit_view.dart';
part './calendar_item_view.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final CalendarViewModel viewModel = CalendarViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("!!!"),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget calenderView() {
    final list = viewModel.eventList;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SizedBox(
          height: Get.height / 3,
          child: ValueListenableBuilder<DateTime>(
            valueListenable: viewModel.focustDayNotifier,
            builder: (context, focusDay, _) {
              return TableCalendar<CalendarEvent>(
                calendarStyle: CalendarStyle(
                  tablePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  selectedDecoration: BoxDecoration(color: WColor.pink),
                  todayDecoration: const BoxDecoration(color: Colors.red),
                ),
                shouldFillViewport: true,
                locale: "ko_KR",
                eventLoader: (day) {
                  return list.where((element) {
                    return isSameDay(day, element.dateTime);
                  }).toList();
                },
                onDaySelected: (selectedDay, focustDay) {
                  viewModel.onTapCalendarDay(selectedDay);
                },
                headerStyle: const HeaderStyle(
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  formatButtonVisible: false,
                  headerPadding: EdgeInsets.only(bottom: 16.0),
                ),
                currentDay: DateTime.now(),
                firstDay: DateTime(1970),
                focusedDay: focusDay,
                selectedDayPredicate: (day) {
                  return isSameDay(day, focusDay);
                },
                lastDay: DateTime(2222),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget eventListView() {
    final list = viewModel.eventList;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: WTitle(
        title: const Text("Event List"),
        child: Expanded(
          child: SlidableAutoCloseBehavior(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final event = list[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: _CalenderItemView(
                      key: viewModel.eventKey(event),
                      event: event,
                      onTapEdit: () {
                        Get.to(
                          _EventEditView(event: event),
                        );
                      },
                      onTapFavorite: () {
                        final newEvent = event.copyWith(
                          isFavorited: !event.isFavorited,
                        );
                        viewModel.updateEvent(newEvent);
                      },
                      onTapPin: () {
                        final newEvent = event.copyWith(
                          isPinned: !event.isPinned,
                        );
                        viewModel.updateEvent(newEvent);
                      },
                      onTapRemove: () {
                        viewModel.removeEvent(event);
                      },
                      onTapShare: () {},
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GetBuilder<CalendarController>(builder: (controller) {
          return Column(
            children: [
              calenderView(),
              Expanded(
                child: eventListView(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
