library feed_repo;

import 'package:wurigiri/data/service.dart';
import 'package:wurigiri/repo/repo.dart';

part './feed_impl.dart';

abstract class FeedRepo extends Repo {
  Future<List<Map<String, dynamic>>> requestFeedList();
  Future updateFeed({
    required String index,
    required Map<String, dynamic> data,
  });
  Future removeFeed(String index);
}
