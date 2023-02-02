import 'package:get/get.dart';
import 'package:wurigiri/model/feed.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';

class FeedController extends GetxController {
  FeedController(this.feedRepo);

  static FeedController find() => Get.find<FeedController>();

  final FeedRepo feedRepo;
  final List<Feed> feedList = [];
  int _currentPage = 0;
  void clearFeedList() {
    feedList.clear();
    _currentPage = 0;
  }

  Future requestFeedList() async {
    final listData = await feedRepo.requestFeedList(_currentPage);
    final list = listData.map((e) {
      return Feed.fromMap(e);
    }).toList();
    feedList.addAll(list);
    feedList.sort();
    update();
    _currentPage++;
  }

  Future updateFeed(Feed newFeed) {
    feedList.add(newFeed);
    update();
    return feedRepo.updateFeed(
      index: newFeed.index,
      data: newFeed.toMap(),
    );
  }

  Future removeFeed(int feedIndex) async {
    feedList.removeWhere((element) => element.index == feedIndex);
    update();
    return feedRepo.removeFeed(feedIndex);
  }
}
