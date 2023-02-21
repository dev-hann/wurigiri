import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/model/chat/chat_room_enter.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/view/chat_view/chat_item_view/chat_item_view.dart';
import 'package:wurigiri/widget/image_picker.dart';

class ChatViewModel {
  final chatController = ChatController.find();
  final userController = UserController.find();
  final fileController = FileController.find();

  late String userID;

  void init() {
    userID = userController.user.id;
    _initChatStream();
    _initChatRoomEnterStrem();
    _initScrollController();
    loadNextChatList();
    chatController.enterChatRoom(userID);
    scrollToBottom();
  }

  void dispose() {
    _chatSub.cancel();
    _chatRoomSub.cancel();
    _disposeScrollController();
  }

  late StreamSubscription _chatSub;
  void _initChatStream() {
    _chatSub = chatController.chatStream().listen(
      (event) {
        final newChat = Chat.fromMap(event);
        final index =
            chatList.indexWhere((element) => newChat.index == element.index);
        if (index == -1) {
          chatList.add(newChat);
        } else {
          chatList[index] = newChat;
        }
        chatController.enterChatRoom(userID);
        chatController.update();
        scrollToBottom();
      },
    );
  }

  final TextEditingController textChatController = TextEditingController();

  void sendTextChat() {
    final text = textChatController.text;
    if (text.isEmpty) {
      return;
    }
    final newChat = TextChat(
      senderIndex: userID,
      dateTime: DateTime.now(),
      text: text,
      replyIndex: replyChat?.index,
    );
    replyChat = null;
    chatController.updateChat(newChat);
    textChatController.clear();
  }

  void sendPhotoChat() async {
    final imageList = await Controller.overlayLoading(
      asyncFunction: () async {
        return await WImagePicker.pickImageList();
      },
    );
    if (imageList.isEmpty) {
      return;
    }
    final newChat = PhotoChat(
      senderIndex: userID,
      dateTime: DateTime.now(),
      photoList: const [],
      thumbList: imageList.map((e) => e.thumbData).toList(),
    );
    chatList.add(newChat);
    chatController.update();
    final List<String> photoList = [];
    for (final image in imageList) {
      final url = await fileController.uploadFile(image.path);
      photoList.add(url);
    }
    final updatedChat = newChat.copyWith(
      photoList: photoList,
    );
    chatController.updateChat(updatedChat);
    chatController.update([chatViewID(updatedChat)]);
  }

  String chatViewID(Chat chat) {
    return "chatViewID ${chat.index}";
  }

  final List<Chat> chatList = [];
  int _currentPage = 1;
  bool _loadingChatList = false;
  Future<void> loadNextChatList() async {
    if (_loadingChatList) {
      return;
    }
    _loadingChatList = true;
    chatList.addAll(chatController.loadChatList(_currentPage));
    _currentPage++;
    chatList.sort();
    await Future.delayed(const Duration(seconds: 2));
    chatController.update();
    _loadingChatList = false;
  }

  final Map<String, ChatRoomEnter> chatEnter = {};

  late StreamSubscription _chatRoomSub;
  void _initChatRoomEnterStrem() {
    _chatRoomSub = chatController.chatRoomEnterStream().listen((event) {
      final chatRoomEnter = ChatRoomEnter.fromMap(event);
      chatEnter[chatRoomEnter.userID] = chatRoomEnter;
      chatController.update();
    });
  }

  bool isReadChat(Chat chat) {
    if (chatEnter.isNotEmpty) {
      for (final enterKey in chatEnter.keys) {
        if (chat.senderIndex != enterKey) {
          final enter = chatEnter[enterKey];
          if (enter == null) {
            return false;
          }
          return enter.dateTime.isAfter(chat.dateTime);
        }
      }
    }
    return false;
  }

  bool isMineChat(Chat chat) {
    return userID == chat.senderIndex;
  }

  User loadUser(String userID) {
    final other = userController.other;
    if (other.id == userID) {
      return other;
    }
    return userController.user;
  }

  final ChatToolpTipController toolTipController = ChatToolpTipController();

  void hideToolTip() {
    toolTipController.hideToolTip();
  }

  void onTapRemoveChat(Chat chat) async {
    // if (chat.type == ChatType.photo) {
    //   final photoChat = chat as PhotoChat;
    //   for (final image in photoChat.photoList) {
    //     fileController.removeFile(image);
    //   }
    // }
    final removedChat = RemovedChat.fromChat(chat);
    await chatController.updateChat(removedChat);
    chatController.update([chatViewID(removedChat)]);
  }

  final String chatBottomViewID = "ChatBottomViewID";

  // Reply
  Chat? replyChat;

  void updateReplyChat(Chat? chat) {
    replyChat = chat;
    chatController.update([chatBottomViewID]);
  }

  Chat? loadChat(int? chatIndex) {
    if (chatIndex == null) {
      return null;
    }
    return chatController.loadChat(chatIndex);
  }

  // Scroll
  final ScrollController scrollController = ScrollController();

  void _initScrollController() {
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    hideToolTip();
    if (scrollController.position.outOfRange) {
      final offset = scrollController.offset;
      if (offset > 0) {
        loadNextChatList();
      }
    }
  }

  void _disposeScrollController() {
    scrollController.removeListener(_scrollListener);
  }

  final Map<int, GlobalKey<ChatItemViewState>> _chatKeyMap = {};

  GlobalKey chatKey(Chat chat) {
    final index = chat.index;
    final key = GlobalKey<ChatItemViewState>();
    _chatKeyMap[index] = key;
    return key;
  }

  void scrollToChat(Chat chat) {
    final key = _chatKeyMap[chat.index];
    if (key == null) {
      return;
    }
    final context = key.currentContext;
    if (context == null) {
      return;
    }

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 300),
      alignment: 0.5,
    ).then((value) => key.currentState!.shake());
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      scrollController.jumpTo(0);
    });
  }

  void onTapReplyChat(Chat chat) {
    scrollToChat(chat);
  }
}
