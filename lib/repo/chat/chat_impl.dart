part of chat_repo;

class ChatImpl extends ChatRepo {
  ChatImpl(this.publicID);
  final String publicID;
  final Service service = Service();
  final DataBase chatDB = DataBase("chat");

  @override
  Future init() async {
    await chatDB.open();
    await chatEnterDB.open();
    _initChatStream();
    _initChatEnterStream();
  }

  bool _chatStreanInited = false;
  void _initChatStream() {
    service.chatRef(publicID).snapshots().listen((event) async {
      if (!_chatStreanInited) {
        _chatStreanInited = true;
        return;
      }
      final itemList = event.docChanges;
      for (final item in itemList) {
        final index = item.doc.id;
        final data = item.doc.data() as Map<String, dynamic>;
        await chatDB.update(index, data);
      }
    });
  }

  @override
  Stream<Map<String, dynamic>> chatStream() {
    return chatDB.stream();
  }

  @override
  List<Map<String, dynamic>> loadChatList(int page) {
    return chatDB.getAll();
  }

  @override
  Future<List<Map<String, dynamic>>> requestChatList() async {
    final snapshot = await service
        .chatRef(publicID)
        .where("dateTime", isGreaterThan: chatDB.lastIndex())
        .get();

    return snapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList();
  }

  @override
  Future updateChat(String index, Map<String, dynamic> data) async {
    return service.chatRef(publicID).doc(index).set(data);
  }

  // ChatEnter
  final chatEnterDB = DataBase("chatEnter");
  void _initChatEnterStream() {
    service.chatEnterRef(publicID).snapshots().listen((event) async {
      final itemList = event.docChanges;
      for (final item in itemList) {
        final index = item.doc.id;
        final data = item.doc.data() as Map<String, dynamic>;
        await chatEnterDB.update(index, data);
      }
    });
  }

  @override
  Stream<Map<String, dynamic>> chatRoomEnterStrem() {
    return chatEnterDB.stream();
  }

  @override
  Future enterChatRoom({
    required String userID,
    required Map<String, dynamic> data,
  }) async {
    return service.chatEnterRef(publicID).doc(userID).set(data);
  }
}
