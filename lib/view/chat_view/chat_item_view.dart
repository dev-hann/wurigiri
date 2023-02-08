import 'package:flutter/material.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/model/user.dart';

class ChatItemView extends StatelessWidget {
  ChatItemView({
    super.key,
    required this.sender,
    required this.chat,
    required this.isRead,
  });
  final User sender;
  final Chat chat;
  final bool isRead;
  final userController = UserController.find();

  bool get isMine => userController.user.id == chat.senderIndex;

  Widget headPhoto() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const SizedBox.square(
        dimension: 48.0,
      ),
    );
  }

  Widget body() {
    final type = chat.type;
    switch (type) {
      case ChatType.text:
        final textChat = chat as TextChat;
        return Text(textChat.text);
    }
  }

  Widget readText() {
    if (!isMine) {
      return const SizedBox();
    }
    return Text(isRead ? "Read" : "");
  }

  Widget tailing() {
    final data = chat.dateTime;
    return Column(
      children: [
        readText(),
        Text("${data.hour}:${data.minute}"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        textDirection: isMine ? TextDirection.rtl : TextDirection.ltr,
        children: [
          headPhoto(),
          const SizedBox(width: 8.0),
          body(),
          const SizedBox(width: 8.0),
          tailing(),
        ],
      ),
    );
  }
}
