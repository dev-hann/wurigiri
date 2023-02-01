library user_repo;

import 'package:platform_device_id/platform_device_id.dart';

part 'user_impl.dart';

abstract class UserRepo {
  Future<String> loadUserID();
}
