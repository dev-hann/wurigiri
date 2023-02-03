part of chat_repo;

class ChatImpl extends ChatRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String chatCollection = "chat";
  CollectionReference get collection => _firestore.collection(chatCollection);

  DocumentReference document(String document) {
    return collection.doc(document);
  }

  final List<Map<String, dynamic>> _tmpChatList = [];
  final StreamController _chatStream = StreamController.broadcast();

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
    final snapshot = await collection.get();
    return snapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList();
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
