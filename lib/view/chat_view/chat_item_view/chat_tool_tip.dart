part of chat_item_view;

class ChatToolTip extends StatelessWidget {
  const ChatToolTip({
    super.key,
    required this.chat,
  });
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text("Remove"),
        ),
      ],
    );
  }
}
