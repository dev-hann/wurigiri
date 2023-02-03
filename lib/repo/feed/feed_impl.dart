part of feed_repo;

class FeedImpl extends FeedRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String feedCollection = "feed";

  CollectionReference get collection => _firestore.collection(feedCollection);

  DocumentReference document(String document) {
    return collection.doc(document);
  }

  @override
  Future init() async {}
  @override
  Future removeFeed(String index) {
    return document(index).delete();
  }

  @override
  Future<List<Map<String, dynamic>>> requestFeedList(
      List<String> feedIndexList) async {
    final snapshot =
        await collection.where("index", whereIn: feedIndexList).get();
    return snapshot.docs
        .where((element) => feedIndexList.contains(element.id))
        .map((e) => e.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Future updateFeed({
    required String index,
    required Map<String, dynamic> data,
  }) {
    return document(index).set(data);
  }
}
