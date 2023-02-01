library notify_repo;

import 'dart:async';

part './notify_impl.dart';

abstract class NotifyRepo {
  Stream<Map<String, dynamic>> notifyStream();
  dynamic loadNotify();
  Future updateNotify(Map<String, dynamic> data);
}
