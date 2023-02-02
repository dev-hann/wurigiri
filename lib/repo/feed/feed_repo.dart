library feed_repo;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wurigiri/data/service.dart';

part './feed_impl.dart';

abstract class FeedRepo {
  Future<List<Map<String, dynamic>>> requestFeedList(int page);
  Future updateFeed({
    required int index,
    required Map<String, dynamic> data,
  });
  Future removeFeed(int index);
}
