part of chat_item_view;

class _ChatTextBody extends StatelessWidget {
  const _ChatTextBody(
    this.chat, {
    required this.replyChat,
  });
  final TextChat chat;
  final Chat? replyChat;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          ReplyChatView(
            replyChat: replyChat,
          ),
          replyChat == null ? const SizedBox() : const Divider(),
          Text(chat.text),
        ],
      ),
    ));
  }
}
