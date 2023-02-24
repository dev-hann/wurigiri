part of calendar_view;

class _EventEditView extends StatelessWidget {
  const _EventEditView({
    required this.event,
  });
  final CalendarEvent event;

  AppBar appBar() {
    return AppBar(
      title: Text(event.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }
}
