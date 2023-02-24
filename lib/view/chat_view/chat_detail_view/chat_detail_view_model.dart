part of chat_detail_view;

class ChatDetailViewModel {
  final chatController = ChatController.find();
  final List<PhotoChat> photoChatList = [];

  List<String> get photoList {
    final List<String> res = [];
    for (final chat in photoChatList.reversed) {
      for (final photo in chat.photoList) {
        res.add(photo);
      }
    }
    return res;
  }

  void init() {
    _initPhotoList();
  }

  void _initPhotoList() {
    int page = 1;
    while (true) {
      final list = chatController.loadChatList(page);
      if (list.isEmpty) {
        photoChatList.sort();
        return;
      }
      for (final chat in list) {
        if (chat.type == ChatType.photo) {
          final photoChat = chat as PhotoChat;
          photoChatList.add(photoChat);
        }
      }
      page++;
    }
  }
}
