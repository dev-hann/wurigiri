import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/repo/user/user_repo.dart';

class UserController extends Controller<UserRepo> {
  static UserController find() => Get.find<UserController>();

  UserController(
    super.userRepo,
  );

  late User user;
  String get publicID => user.publicID;
  late final User other;

  Future<User?> requestUser(String userID) async {
    final userData = await repo.requestUser(userID);
    if (userData == null) {
      return null;
    }
    return User.fromMap(userData);
  }

  Future updateUser(
    User newUser, {
    bool withServer = false,
  }) async {
    if (withServer) {
      await repo.updateUser(
        id: newUser.id,
        data: newUser.toMap(),
      );
    }
    user = newUser;
  }
}
