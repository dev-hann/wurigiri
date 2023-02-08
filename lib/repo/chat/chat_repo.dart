library chat_repo;

import 'dart:async';

import 'package:wurigiri/data/data_base.dart';
import 'package:wurigiri/data/service.dart';
import 'package:wurigiri/repo/repo.dart';

part './chat_impl.dart';

abstract class ChatRepo extends Repo {
  Stream<Map<String, dynamic>> chatStream();
  Future<List<Map<String, dynamic>>> requestChatList();
  List<Map<String, dynamic>> loadChatList(int page);
  Future updateChat(String index, Map<String, dynamic> data);

  Stream<Map<String, dynamic>> chatRoomEnterStrem();

  Future enterChatRoom({
    required String userID,
    required Map<String, dynamic> data,
  });
}
