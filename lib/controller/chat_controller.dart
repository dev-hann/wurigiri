import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';

class ChatController extends Controller<ChatRepo> {
  ChatController(super.repo);

  static ChatController find() => Get.find<ChatController>();
  final List<Chat> chatList = [];

  @override
  void onReady() {
    _initChatStream();
    super.onReady();
  }

  void _initChatStream() {
    repo.chatStream().listen((event) {
      final newChat = Chat.fromMap(event);
      final index =
          chatList.indexWhere((element) => newChat.index == element.index);
      if (index == -1) {
        chatList.add(newChat);
      } else {
        chatList[index] = newChat;
      }
      update();
    });
  }

  int _currentPage = 1;
  void refreshChatList() {
    _currentPage = 1;
    chatList.clear();
    loadChatList();
  }

  void loadChatList() {
    final list = repo.loadChatList(1);
    chatList.addAll(list.map((e) => Chat.fromMap(e)));
    _currentPage++;
  }

  Future requestChatList() async {}
  Future updateChat(Chat chat) async {
    repo.updateChat(
      "${chat.index}",
      chat.toMap(),
    );
  }
}
