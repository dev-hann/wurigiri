import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/view/chat_view/chat_item_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final chatController = ChatController.find();
  final userController = UserController.find();
  final TextEditingController textChatController = TextEditingController();
  @override
  void initState() {
    super.initState();
    chatController.loadChatList();
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("ChatView"),
    );
  }

  Widget bottom() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textChatController,
          ),
        ),
        IconButton(
          onPressed: () {
            final newChat = TextChat(
              senderIndex: userController.user.id + "1",
              dateTime: DateTime.now(),
              text: textChatController.text,
            );
            chatController.updateChat(newChat);
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: appBar(),
        bottomSheet: bottom(),
        body: GetBuilder<ChatController>(
          builder: (controller) {
            final chatList = controller.chatList.reversed.toList();
            return ListView.builder(
              padding: const EdgeInsets.only(
                bottom: kToolbarHeight,
              ),
              reverse: true,
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return ChatItemView(
                  chat: chatList[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
