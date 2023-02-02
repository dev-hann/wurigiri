library chat_repo;

import 'dart:async';

import 'package:wurigiri/data/service.dart';

part './chat_impl.dart';

abstract class ChatRepo {
  Stream<Map<String, dynamic>> chatStream();
  Future<List<Map<String, dynamic>>> requestChatList();
  Future<List<Map<String, dynamic>>> loadChatList(int page);
  Future updateChat(String index, Map<String, dynamic> data);

  Future enterChatRoom(String userID);
}
