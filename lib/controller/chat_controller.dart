import 'package:get/get.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';

class ChatController extends GetxController {
  ChatController(this.chatRepo);

  static ChatController find() => Get.find<ChatController>();

  final ChatRepo chatRepo;

  final List<Chat> chatList = [];

  @override
  void onReady() {
    _initChatStream();
    super.onReady();
  }

  void _initChatStream() {
    chatRepo.chatStream().listen((event) {
      final newChat = Chat.fromMap(event);
      chatList.add(newChat);
      update();
    });
  }

  Future loadChatList() async {}
  Future requestChatList() async {}
  Future updateChat(Chat chat) async {
    chatRepo.updateChat(
      "${chat.index}",
      chat.toMap(),
    );
  }
}
