library login_repo;

import 'package:platform_device_id/platform_device_id.dart';
import 'package:wurigiri/data/service.dart';

part 'login_impl.dart';

abstract class LoginRepo {
  Future<String> loadDeviceID();

  String inviteCode();
  Stream<Map<String, dynamic>> connectStream(String inviteCode);
  Future invite({
    required String inviteCode,
    required Map<String, dynamic> data,
  });

  Future cancelInvite(String inviteCode);
}
