part of chat_repo;

class ChatImpl extends ChatRepo {
  ChatImpl(this.publicID);
  final String publicID;
  final Service service = Service();
  final DataBase chatDB = DataBase("chat");

  @override
  Future init() async {
    await chatDB.open();
    _initStream();
  }

  bool _streanInited = false;
  void _initStream() {
    service.chatRef(publicID).snapshots().listen((event) async {
      if (!_streanInited) {
        _streanInited = true;
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

  @override
  Future enterChatRoom(String userID) {
    // TODO: implement enterChatRoom
    throw UnimplementedError();
  }
}
