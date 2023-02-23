import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/model/calender_event.dart';
import 'package:wurigiri/repo/calendar/calendar_repo.dart';

class CalendarController extends Controller<CalendarRepo> {
  CalendarController(super.repo);

  static CalendarController find() => Get.find<CalendarController>();
  Future<List<CalendarEvent>> requestEventList() async {
    return [];
  }

  Future updateEvent(CalendarEvent event) async {}

  Future removeEvent(CalendarEvent event) async {}
}
