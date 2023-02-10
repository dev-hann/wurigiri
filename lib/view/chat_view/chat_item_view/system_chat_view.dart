part of chat_item_view;

class SystemChatView extends StatelessWidget {
  const SystemChatView({
    super.key,
    required this.chat,
  });
  final SystemChat chat;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(chat.message),
        ),
      ],
    );
  }
}
