part of feed_repo;

class FeedImpl extends FeedRepo {
  final FireService service = FireService();
  final String feedKey = "feed";
  @override
  Future removeFeed(int index) {
    return service.remove(
      collection: feedKey,
      document: "$index",
    );
  }

  @override
  Future<List<Map<String, dynamic>>> requestFeedList(int page) async {
    return await service.getDocumentList(feedKey);
  }

  @override
  Future updateFeed({
    required int index,
    required Map<String, dynamic> data,
  }) {
    return service.update(
      collection: feedKey,
      document: "$index",
      data: data,
    );
  }
}
