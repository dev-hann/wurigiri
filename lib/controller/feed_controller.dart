import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/model/feed.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';

class FeedController extends Controller<FeedRepo> {
  FeedController(super.repo);

  static FeedController find() => Get.find<FeedController>();

  Future<List<Feed>> requestFeedList({
    required int page,
  }) async {
    final listData = await repo.requestFeedList();
    return listData.map((e) {
      return Feed.fromMap(e);
    }).toList();
  }

  Future updateFeed({
    required Feed newFeed,
  }) {
    return repo.updateFeed(
      index: newFeed.index,
      data: newFeed.toMap(),
    );
  }

  Future removeFeed(String feedIndex) async {
    return repo.removeFeed(feedIndex);
  }
}
