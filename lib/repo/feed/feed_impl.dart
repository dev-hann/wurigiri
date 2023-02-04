part of feed_repo;

class FeedImpl extends FeedRepo {
  FeedImpl(this.publicID);
  final String publicID;
  final Service service = Service();

  @override
  Future init() async {}
  @override
  Future removeFeed(String index) {
    return service.feedRef(publicID).doc(index).delete();
  }

  @override
  Future<List<Map<String, dynamic>>> requestFeedList() async {
    final snapshot = await service.feedRef(publicID).get();
    return snapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList();
  }

  @override
  Future updateFeed({
    required String index,
    required Map<String, dynamic> data,
  }) {
    return service.feedRef(publicID).doc(index).set(data);
  }
}
