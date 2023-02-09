import 'dart:async';

import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/model/connection.dart';
import 'package:wurigiri/model/public.dart';
import 'package:wurigiri/repo/login/login_repo.dart';

class LoginController extends Controller<LoginRepo> {
  LoginController(super.repo);

  static LoginController find() => Get.find<LoginController>();

  Future<String> loadDeviceID() {
    return repo.loadDeviceID();
  }

  StreamSubscription? _inviteSub;
  void _initConnectStream(String inviteCode) {
    _inviteSub = repo.connectStream(inviteCode).listen((event) {
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
    return repo.disposeInvite(inviteCode);
  }

  Future<String> invite() async {
    final inviteCode = repo.inviteCode();
    _initConnectStream(inviteCode);
    await repo.updateConnection(
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
    final connectionData = await repo.requestConnection(inviteCode);
    if (connectionData == null) {
      return null;
    }
    final connection = Connection.fromMap(connectionData);
    await repo.updateConnection(
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
    return repo.connected(
      inviteCode,
      Public.empty().toMap(),
    );
  }
}
