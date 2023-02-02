library setting_repo;

import 'package:wurigiri/data/service.dart';

part './setting_impl.dart';

abstract class SettingRepo {
  Stream<Map<String, dynamic>?> get settingStream;
  Future<dynamic> updateSetting(Map<String, dynamic> data);
}
