import 'dart:async';

import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/model/connection.dart';
import 'package:wurigiri/model/public.dart';
import 'package:wurigiri/repo/login/login_repo.dart';

class LoginController extends Controller<LoginRepo> {
  LoginController(super.repo);

  static LoginController find() => Get.find<LoginController>();

  Future<String> requestDeviceID() {
    return repo.requestDeviceID();
  }

  Stream<Connection?> connectionStream(String inviteCode) {
    return repo.connectStream(inviteCode).map((event) {
      if (event == null) {
        return null;
      }
      return Connection.fromMap(event);
    });
  }

  String loadInviteCode() {
    return repo.inviteCode();
  }

  Future disposeInvite(String inviteCode) {
    return repo.disposeInvite(inviteCode);
  }

  Future updateConnection({
    required String inviteCode,
    required Connection connection,
  }) {
    return repo.updateConnection(
      inviteCode: inviteCode,
      data: connection.toMap(),
    );
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
            guest: await requestDeviceID(),
          )
          .toMap(),
    );
    return connection;
  }

  Future initPublic(String inviteCode) {
    return repo.initPublic(
      inviteCode,
      Public.empty().toMap(),
    );
  }
}
