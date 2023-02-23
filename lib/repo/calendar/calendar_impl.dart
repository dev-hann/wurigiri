part of calendar_repo;

class CalendarImpl extends CalendarRepo {
  CalendarImpl(this.publicID);
  final String publicID;

  @override
  Future init() async {}
}
