import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/model/chat/chat_room_enter.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';

class ChatController extends Controller<ChatRepo> {
  ChatController(super.repo);

  static ChatController find() => Get.find<ChatController>();

  Stream<Map<String, dynamic>> chatStream() => repo.chatStream();

  List<Chat> loadChatList(int page) {
    final list = repo.loadChatList(page);
    return list.map((e) => Chat.fromMap(e)).toList();
  }

  Future updateChat(Chat chat) {
    return repo.updateChat(
      "${chat.index}",
      chat.toMap(),
    );
  }

  Stream<Map<String, dynamic>> chatRoomEnterStream() =>
      repo.chatRoomEnterStrem();

  Future enterChatRoom(String userID) async {
    final enter = ChatRoomEnter.now(userID);
    return repo.enterChatRoom(
      userID: userID,
      data: enter.toMap(),
    );
  }
}
