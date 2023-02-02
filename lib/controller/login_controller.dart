import 'dart:async';

import 'package:get/get.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/repo/login/login_repo.dart';

class LoginController extends GetxController {
  LoginController(this.loginRepo);

  static LoginController find() => Get.find<LoginController>();

  final LoginRepo loginRepo;

  Future<String> loadDeviceID() {
    return loginRepo.loadDeviceID();
  }

  void _initConnectStream(String inviteCode) {
    _inviteSub = loginRepo.connectStream(inviteCode).listen((event) {
      final user = User.fromMap(event);
      if (user.shareIndex.isNotEmpty) {
        print(user);
        cancelInvite(inviteCode);
        Get.back();
      }
    });
  }

  StreamSubscription? _inviteSub;
  Future<String> invite(User newUser) async {
    final inviteCode = loginRepo.inviteCode();
    await loginRepo.invite(
      inviteCode: inviteCode,
      data: newUser.toMap(),
    );
    _initConnectStream(inviteCode);
    return inviteCode;
  }

  Future cancelInvite(String inviteCode) {
    _inviteSub?.cancel();
    return loginRepo.cancelInvite(inviteCode);
  }

  Future connect({
    required String otherInviteCode,
    required User newUser,
  }) async {}
}
