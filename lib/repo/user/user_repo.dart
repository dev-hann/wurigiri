library user_repo;

import 'package:wurigiri/data/service.dart';

part 'user_impl.dart';

abstract class UserRepo {
  Future<List<Map<String, dynamic>>> requestUserList();

  dynamic loadUser();
  Future<dynamic> requestUser(String deviceID);
  Future<dynamic> updateUser({
    required String id,
    required Map<String, dynamic> data,
  });
}
