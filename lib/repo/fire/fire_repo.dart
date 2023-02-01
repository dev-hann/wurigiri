library fire_repo;

import 'package:wurigiri/data/service.dart';

part './fire_impl.dart';

abstract class FireRepo {
  Future<dynamic> requestUser(String deviceID);
  Future<dynamic> updateUser({
    required String key,
    required Map<String, dynamic> data,
  });

  Stream<Map<String, dynamic>?> get settingStream;
  Future<dynamic> updateSetting(Map<String, dynamic> data);
}
