part of chat_repo;

class ChatImpl extends ChatRepo {
  final FireService service = FireService();

  final List<Map<String, dynamic>> _tmpChatList = [];
  final StreamController _chatStream = StreamController.broadcast();

  final String chatKey = "chat";

  @override
  Stream<Map<String, dynamic>> chatStream() {
    return _chatStream.stream.map((event) {
      return Map<String, dynamic>.from(event);
    });
  }

  @override
  Future<List<Map<String, dynamic>>> loadChatList(int page) async {
    return _tmpChatList;
  }

  @override
  Future<List<Map<String, dynamic>>> requestChatList() async {
    return await service.getDocumentList(chatKey);
  }

  @override
  Future updateChat(String index, Map<String, dynamic> data) async {
    _chatStream.add(data);
    // return service.update(
    //   collection: chatKey,
    //   document: index,
    //   data: data,
    // );
  }

  @override
  Future enterChatRoom(String userID) {
    // TODO: implement enterChatRoom
    throw UnimplementedError();
  }
}
