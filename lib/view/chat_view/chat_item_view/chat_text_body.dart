part of chat_item_view;

class _ChatTextBody extends StatelessWidget {
  const _ChatTextBody(
    this.chat, {
    required this.replyChat,
    required this.onTapReply,
  });
  final TextChat chat;
  final Chat? replyChat;
  final Function(Chat replyChat) onTapReply;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReplyChatView(
              replyChat: replyChat,
              onTapReply: onTapReply,
            ),
            replyChat == null ? const SizedBox() : const Divider(),
            Text(chat.text),
          ],
        ),
      ),
    ));
  }
}
