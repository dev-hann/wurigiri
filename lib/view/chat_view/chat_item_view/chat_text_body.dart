part of chat_item_view;

class _ChatTextBody extends StatelessWidget {
  const _ChatTextBody(this.chat);
  final TextChat chat;

  @override
  Widget build(BuildContext context) {
    return Text(chat.text);
  }
}
