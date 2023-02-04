library login_repo;

import 'package:platform_device_id/platform_device_id.dart';
import 'package:wurigiri/data/service.dart';

part 'login_impl.dart';

abstract class LoginRepo {
  Future<String> loadDeviceID();

  String inviteCode();
  Stream<Map<String, dynamic>> connectStream(String inviteCode);
  Future updateConnection({
    required String inviteCode,
    required Map<String, dynamic> data,
  });
  Future<dynamic> requestConnection(String inviteCode);

  Future disposeInvite(String inviteCode);

  Future connected(String inviteCode, Map<String, dynamic> data);
}
