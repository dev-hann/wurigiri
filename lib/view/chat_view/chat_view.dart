import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/view/chat_view/chat_item_view/chat_item_view.dart';
import 'package:wurigiri/view/chat_view/chat_view_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatViewModel viewModel = ChatViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("ChatView"),
    );
  }

  Widget bottom() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            viewModel.sendPhotoChat();
          },
          icon: const Icon(Icons.photo),
        ),
        Expanded(
          child: TextField(
            controller: viewModel.textChatController,
          ),
        ),
        IconButton(
          onPressed: () async {
            viewModel.sendTextChat();
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
            final chatList = viewModel.chatList.reversed.toList();
            return ListView.builder(
              padding: const EdgeInsets.only(
                bottom: kToolbarHeight,
              ),
              reverse: true,
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                final chat = chatList[index];
                return GetBuilder<ChatController>(
                  id: viewModel.chatViewID(chat),
                  builder: (_) {
                    return ChatItemView(
                      key: ValueKey(chat.index),
                      chat: chat,
                      sender: viewModel.loadUser(chat.senderIndex),
                      isRead: viewModel.isReadChat(chat),
                      isMine: viewModel.isMineChat(chat),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
