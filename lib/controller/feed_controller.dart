import 'dart:math';

import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/model/feed.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';

class FeedController extends Controller<FeedRepo> {
  FeedController(super.repo);

  static FeedController find() => Get.find<FeedController>();

  final List<Feed> feedList = [];
  final List<String> feedIndexList = [];

  int _currentPage = 1;
  Future refreshFeedList([List<String>? feedIndexList]) async {
    _currentPage = 1;
    feedList.clear();
    if (feedIndexList != null) {
      this.feedIndexList.clear();
      this.feedIndexList.addAll(feedIndexList);
    }
    requestFeedList();
  }

  Future requestFeedList() async {
    final listData = await repo.requestFeedList(
      feedIndexList.sublist(
        0,
        min(_currentPage * 21, feedIndexList.length),
      ),
    );
    final list = listData.map((e) {
      return Feed.fromMap(e);
    }).toList();
    feedList.addAll(list);
    feedList.sort();
    update();
    _currentPage++;
  }

  Future updateFeed({
    required Feed newFeed,
  }) {
    feedList.add(newFeed);
    feedList.sort();
    feedIndexList.add(newFeed.index);
    update();
    return repo.updateFeed(
      index: newFeed.index,
      data: newFeed.toMap(),
    );
  }

  Future removeFeed(String feedIndex) async {
    feedList.removeWhere((element) => element.index == feedIndex);
    update();
    feedIndexList.removeWhere((element) => element == feedIndex);
    return repo.removeFeed(feedIndex);
  }
}
