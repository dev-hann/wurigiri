import 'package:get/get.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/repo/fire/fire_repo.dart';
import 'package:wurigiri/repo/user/user_repo.dart';

class UserController extends GetxController {
  static UserController find() => Get.find<UserController>();

  UserController(
    this.userRepo,
    this.fireRepo,
  );

  final UserRepo userRepo;
  final FireRepo fireRepo;

  late final User user;

  Future<User?> requestUser() async {
    final deviceID = await userRepo.loadUserID();
    final userData = await fireRepo.requestUser(deviceID);
    if (userData == null) {
      return null;
    }
    final newUser = User.fromMap(userData);
    user = newUser;
    return newUser;
  }

  Future updateUser(User newUser) async {
    await fireRepo.updateUser(
      key: newUser.id,
      data: newUser.toMap(),
    );
    user = newUser;
  }
}
