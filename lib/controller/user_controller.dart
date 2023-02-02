import 'package:get/get.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/repo/user/user_repo.dart';

class UserController extends GetxController {
  static UserController find() => Get.find<UserController>();

  UserController(
    this.userRepo,
  );

  final UserRepo userRepo;

  late User user;
  late final User other;

  bool loadUser() {
    final userData = userRepo.loadUser();
    if (userData == null) {
      return false;
    }
    final user = User.fromMap(userData);
    if (user.shareIndex.isEmpty) {
      return false;
    }
    this.user = user;
    return true;
  }

  Future<User?> requestUser(String userID) async {
    final userData = await userRepo.requestUser(userID);
    if (userData == null) {
      return null;
    }
    return User.fromMap(userData);
  }

  Future updateUser(User newUser) async {
    await userRepo.updateUser(
      id: newUser.id,
      data: newUser.toMap(),
    );
    user = newUser;
  }
}
