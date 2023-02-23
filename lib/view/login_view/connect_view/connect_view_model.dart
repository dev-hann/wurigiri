part of connect_view;

class ConnectViewModel {
  final userController = UserController.find();
  final loginController = LoginController.find();
  final codeController = TextEditingController();

  Future<bool> connect({
    String? inviteCode,
    String? guestID,
  }) async {
    return Controller.overlayLoading<bool>(
      asyncFunction: () async {
        final publicID = inviteCode ?? codeController.text;
        if (publicID.isEmpty) {
          return false;
        }
        String? otherID = guestID;
        if (otherID == null) {
          final connection = await loginController.connect(publicID);
          if (connection == null) {
            return false;
          }
          otherID = connection.invitator;
        }
        final newUser = userController.user.copyWith(
          publicID: publicID,
          otherID: otherID,
        );
        await userController.updateUser(
          newUser,
          withServer: true,
        );
        loginController.initPublic(publicID);
        return true;
      },
    );
  }

  String? _inviteCode;
  String get inviteCode {
    return _inviteCode ??= loginController.loadInviteCode();
  }

  Stream<Connection?> connectionStream() {
    return loginController.connectionStream(inviteCode);
  }

  StreamSubscription? _connectionSub;
  Future initInvite({
    required Function(Connection connection) onConnection,
  }) async {
    final code = inviteCode;
    await Controller.overlayLoading(asyncFunction: () async {
      await loginController.updateConnection(
        inviteCode: code,
        connection: Connection(
          publicID: code,
          invitator: await loginController.requestDeviceID(),
          guest: "",
        ),
      );
    });
    _connectionSub = loginController.connectionStream(code).listen((event) {
      if (event != null) {
        onConnection(event);
      }
    });
  }

  Future disposeInvite() {
    _connectionSub?.cancel();
    return loginController.disposeInvite(inviteCode);
  }
}
