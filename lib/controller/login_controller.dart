import 'dart:async';

import 'package:get/get.dart';
import 'package:wurigiri/model/connection.dart';
import 'package:wurigiri/model/public.dart';
import 'package:wurigiri/repo/login/login_repo.dart';

class LoginController extends GetxController {
  LoginController(this.loginRepo);

  static LoginController find() => Get.find<LoginController>();

  final LoginRepo loginRepo;

  Future<String> loadDeviceID() {
    return loginRepo.loadDeviceID();
  }

  StreamSubscription? _inviteSub;
  void _initConnectStream(String inviteCode) {
    _inviteSub = loginRepo.connectStream(inviteCode).listen((event) {
      if (event.isEmpty) {
        return;
      }
      final connection = Connection.fromMap(event);
      if (connection.guest && connection.invitator) {
        _inviteSub?.cancel();
        cancelInvite(inviteCode);
        if (Get.isDialogOpen ?? false) {
          Get.back(result: inviteCode);
        }
      }
    });
  }

  Future cancelInvite(String inviteCode) {
    return loginRepo.disposeInvite(inviteCode);
  }

  Future<String> invite() async {
    final inviteCode = loginRepo.inviteCode();
    _initConnectStream(inviteCode);
    await loginRepo.updateConnection(
      inviteCode: inviteCode,
      data: const Connection(
        invitator: true,
        guest: false,
      ).toMap(),
    );
    return inviteCode;
  }

  Future connect(String inviteCode) async {
    final connectionData = await loginRepo.requestConnection(inviteCode);
    if (connectionData == null) {
      return;
    }
    final connection = Connection.fromMap(connectionData);
    await loginRepo.updateConnection(
      inviteCode: inviteCode,
      data: connection.copyWith(guest: true).toMap(),
    );
  }

  Future connected(inviteCode) {
    return loginRepo.connected(
      inviteCode,
      Public.empty().toMap(),
    );
  }
}
