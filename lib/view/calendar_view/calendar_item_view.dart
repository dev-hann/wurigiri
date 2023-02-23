part of calendar_view;

class _CalenderItemView extends StatefulWidget {
  const _CalenderItemView({
    super.key,
    required this.event,
    required this.onTapEdit,
    required this.onTapFavorite,
    required this.onTapPin,
    required this.onTapRemove,
    required this.onTapShare,
  });
  final CalendarEvent event;
  final VoidCallback onTapEdit;
  final VoidCallback onTapPin;
  final VoidCallback onTapFavorite;
  final VoidCallback onTapShare;
  final VoidCallback onTapRemove;

  @override
  State<_CalenderItemView> createState() => _CalenderItemViewState();
}

class _CalenderItemViewState extends State<_CalenderItemView>
    with AutomaticKeepAliveClientMixin {
  Widget ddayText(DateTime dateTime) {
    final days = WTimeFormat(dateTime).calculateDay();
    return Text("$days일");
  }

  Widget badge() {
    final List<Widget> itemList = [];
    final event = widget.event;
    if (event.isFavorited) {
      itemList.add(
        const Icon(
          Icons.favorite,
          size: 14.0,
        ),
      );
    }
    if (event.isPinned) {
      itemList.add(
        const Icon(
          Icons.pin_drop,
          size: 14.0,
        ),
      );
    }
    return Row(
      children: itemList,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final event = widget.event;
    final dateTime = event.dateTime;
    return Slidable(
      groupTag: "_CalenderItemView",
      key: ValueKey(event),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            autoClose: false,
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.pin_drop,
            onPressed: (context) async {
              widget.onTapPin();
              await Slidable.of(context)?.close();
            },
          ),
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.favorite,
            onPressed: (context) async {
              widget.onTapFavorite();
              await Slidable.of(context)?.close();
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            onPressed: (context) async {
              await Slidable.of(context)?.close();
              widget.onTapShare();
            },
          ),
          SlidableAction(
            autoClose: false,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            onPressed: (context) {
              final controller = Slidable.of(context);
              controller?.dismiss(
                ResizeRequest(
                  const Duration(milliseconds: 300),
                  () {
                    widget.onTapRemove();
                  },
                ),
                duration: const Duration(milliseconds: 500),
              );
            },
            icon: Icons.delete,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: widget.onTapEdit,
        child: ListTile(
          title: badges.Badge(
            position: badges.BadgePosition.bottomEnd(),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.transparent,
              shape: badges.BadgeShape.twitter,
              elevation: 0.0,
            ),
            badgeContent: badge(),
            child: Text(widget.event.title),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ddayText(dateTime),
              Text(WTimeFormat(dateTime).dateFormat),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
