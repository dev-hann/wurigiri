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
      if (event == null) {
        return;
      }
      final connection = Connection.fromMap(event);
      if (connection.guest.isNotEmpty && connection.invitator.isNotEmpty) {
        _inviteSub?.cancel();
        cancelInvite(inviteCode);
        if (Get.isDialogOpen ?? false) {
          Get.back(result: connection);
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
      data: Connection(
        publicID: inviteCode,
        invitator: await loadDeviceID(),
        guest: "",
      ).toMap(),
    );
    return inviteCode;
  }

  Future<Connection?> connect(String inviteCode) async {
    final connectionData = await loginRepo.requestConnection(inviteCode);
    if (connectionData == null) {
      return null;
    }
    final connection = Connection.fromMap(connectionData);
    await loginRepo.updateConnection(
      inviteCode: inviteCode,
      data: connection
          .copyWith(
            guest: await loadDeviceID(),
          )
          .toMap(),
    );
    return connection;
  }

  Future connected(inviteCode) {
    return loginRepo.connected(
      inviteCode,
      Public.empty().toMap(),
    );
  }
}
