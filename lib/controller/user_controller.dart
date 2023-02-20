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
  late User other;

  String get publicID => user.publicID;

  Future reqeustOther() async {
    final otherData = await requestUser(user.otherID);
    if (otherData != null) {
      other = otherData;
    }
  }

  User loadUser(String index) {
    if (user.id == index) {
      return user;
    }
    return other;
  }

  Future<User?> requestUser(String deviceID) async {
    final userData = await repo.requestUser(deviceID);
    if (userData == null) {
      return null;
    }
    return User.fromMap(userData);
  }

  Future updateUser(
    User newUser, {
    bool withServer = false,
  }) async {
    user = newUser;
    update();
    if (withServer) {
      await repo.updateUser(
        id: newUser.id,
        data: newUser.toMap(),
      );
    }
  }
}
