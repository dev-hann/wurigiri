import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/model/feed.dart';

class FeedViewModel {
  final feedController = FeedController.find();

  final List<Feed> feedList = [];

  void init() async {
    final list = await feedController.requestFeedList(page: 1);
    feedList.addAll(list);
    feedList.sort();
    feedController.update();
  }

  void updateFeed(Feed newFeed) async {
    Controller.overlayLoading(asyncFunction: () async {
      await feedController.updateFeed(newFeed: newFeed);
      feedList.add(newFeed);
      feedList.sort();
      feedController.update();
    });
  }

  void removeFeed(String feedIndex) {
    Controller.overlayLoading(asyncFunction: () async {
      await feedController.removeFeed(feedIndex);
      feedList.removeWhere((element) => element.index == feedIndex);
      feedController.update();
    });
  }
}
