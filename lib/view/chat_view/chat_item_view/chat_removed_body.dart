part of chat_item_view;

class _ChatRemovedBody extends StatelessWidget {
  const _ChatRemovedBody({
    required this.chat,
  });
  final RemovedChat chat;

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Text("Removed Chat!!"),
      ),
    );
  }
}
