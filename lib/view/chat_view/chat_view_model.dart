import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/model/chat/chat_room_enter.dart';
import 'package:wurigiri/model/user.dart';
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
    loadNextChatList();
    chatController.enterChatRoom(userID);
  }

  void dispose() {
    _chatSub.cancel();
    _chatRoomSub.cancel();
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
      },
    );
  }

  final TextEditingController textChatController = TextEditingController();

  void sendTextChat() {
    final newChat = TextChat(
      senderIndex: userID,
      dateTime: DateTime.now(),
      text: textChatController.text,
    );
    chatController.updateChat(newChat);
    textChatController.clear();
  }

  void sendPhotoChat() async {
    final image = await chatController.loadingOverlay(
      asyncFunction: () async {
        return await WImagePicker.pickImage();
      },
    );
    if (image == null) {
      return;
    }
    final newChat = PhotoChat(
      senderIndex: userID,
      dateTime: DateTime.now(),
      photoURL: "",
      thumbData: image.thumbData,
    );
    chatList.add(newChat);
    chatController.update();
    final photoURL = await fileController.uploadFile(image.path);
    final updatedChat = newChat.copyWith(
      photoURL: photoURL,
    );
    chatController.updateChat(updatedChat);
    chatController.update([chatViewID(updatedChat)]);
  }

  String chatViewID(Chat chat) {
    return "chatViewID ${chat.index}";
  }

  final List<Chat> chatList = [];
  int _currentPage = 1;
  void loadNextChatList() {
    chatList.addAll(chatController.loadChatList(_currentPage));
    _currentPage++;
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
}
