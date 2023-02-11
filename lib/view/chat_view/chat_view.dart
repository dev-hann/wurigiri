import 'package:cached_network_image/cached_network_image.dart';
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
    Widget replyView(Chat? replyChat) {
      if (replyChat == null) {
        return const SizedBox();
      }
      Widget header = const SizedBox();
      Widget body = const SizedBox();
      if (replyChat.type == ChatType.photo) {}
      switch (replyChat.type) {
        case ChatType.text:
          body = Text(
            (replyChat as TextChat).text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          );
          break;
        case ChatType.photo:
          header = Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CachedNetworkImage(
              imageUrl: (replyChat as PhotoChat).photoURL,
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
          );
          body = const Text("사진");
          break;
        case ChatType.system:
          break;
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            header,
            Expanded(child: body),
            IconButton(
              onPressed: () {
                viewModel.updateReplyChat(null);
              },
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
      );
    }

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
              padding: const EdgeInsets.all(8.0),
              child: ReplyChatView(
                replyChat: replyChat,
                onTapCancel: () {
                  viewModel.updateReplyChat(null);
                },
              ),
            ),
            Row(
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
          ],
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
          maintainBottomViewPadding: true,
          child: Scaffold(
            appBar: appBar(),
            bottomSheet: bottom(),
            body: GetBuilder<ChatController>(
              builder: (controller) {
                final chatList = viewModel.chatList.reversed.toList();
                return ListView.builder(
                  controller: viewModel.scrollController,
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
                        final sender = viewModel.loadUser(chat.senderIndex);
                        final replyChat = chat is TextChat
                            ? viewModel.loadChat(chat.replyIndex)
                            : null;
                        return ChatItemView(
                          chat: chat,
                          replyChat: replyChat,
                          toolTipController: viewModel.toolTipController,
                          sender: sender,
                          isRead: viewModel.isReadChat(chat),
                          isMine: viewModel.isMineChat(chat),
                          onTapHeadPhoto: () {
                            Get.to(UserDetailView(user: sender));
                          },
                          onTapRemove: () {
                            viewModel.onTapRemoveChat(chat);
                          },
                          onTapReply: () {
                            viewModel.updateReplyChat(chat);
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
