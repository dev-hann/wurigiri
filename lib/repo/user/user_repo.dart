library user_repo;

import 'package:wurigiri/data/service.dart';
import 'package:wurigiri/repo/repo.dart';

part 'user_impl.dart';

abstract class UserRepo extends Repo {
  Future<dynamic> requestUser(String deviceID);
  Future<dynamic> updateUser({
    required String id,
    required Map<String, dynamic> data,
  });
}
