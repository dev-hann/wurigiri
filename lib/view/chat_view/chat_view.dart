import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/view/chat_view/chat_item_view/chat_item_view.dart';
import 'package:wurigiri/view/chat_view/chat_view_model.dart';
import 'package:wurigiri/view/chat_view/reply_chat_view.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view.dart';

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
    Widget photoButton(Chat? replyChat) {
      if (replyChat != null) {
        return const SizedBox();
      }
      return IconButton(
        onPressed: () {
          viewModel.sendPhotoChat();
        },
        icon: const Icon(Icons.photo),
      );
    }

    Widget textField(Chat? replyChat) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: viewModel.textChatController,
            textInputAction: TextInputAction.newline,
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              prefixIcon: replyChat != null ? const Icon(Icons.comment) : null,
              border: InputBorder.none,
              hintText: replyChat != null ? "답변쓰기" : "Aa",
            ),
          ),
        ),
      );
    }

    return GetBuilder<ChatController>(
      id: viewModel.chatBottomViewID,
      builder: (context) {
        final replyChat = viewModel.replyChat;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ReplyChatView(
                replyChat: replyChat,
                onTapCancel: () {
                  viewModel.updateReplyChat(null);
                },
              ),
            ),
            ColoredBox(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  photoButton(replyChat),
                  Expanded(
                    child: textField(replyChat),
                  ),
                  IconButton(
                    onPressed: () async {
                      viewModel.sendTextChat();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget chatItem(Chat chat) {
    return GetBuilder<ChatController>(
      id: viewModel.chatViewID(chat),
      builder: (_) {
        final sender = viewModel.loadUser(chat.senderIndex);
        final replyChat =
            chat is TextChat ? viewModel.loadChat(chat.replyIndex) : null;
        return ChatItemView(
          key: viewModel.chatKey(chat),
          chat: chat,
          replyChat: replyChat,
          toolTipController: viewModel.toolTipController,
          sender: sender,
          isRead: viewModel.isReadChat(chat),
          isMine: viewModel.isMineChat(chat),
          onTapHeadPhoto: () {
            Get.to(UserDetailView(user: sender));
          },
          onTapToolTipRemove: () {
            viewModel.onTapRemoveChat(chat);
          },
          onTapToolTipReply: () {
            viewModel.updateReplyChat(chat);
          },
          onTapReply: (replyChat) {
            viewModel.onTapReplyChat(replyChat);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        viewModel.hideToolTip();
      },
      child: Material(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            appBar: appBar(),
            body: GetBuilder<ChatController>(
              builder: (controller) {
                final chatList = viewModel.chatList.toList();
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: viewModel.scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(height: 40.0),
                            for (int index = 0;
                                index < chatList.length;
                                index++)
                              chatItem(chatList[index]),
                          ],
                        ),
                      ),
                    ),
                    bottom(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
