part of login_repo;

class LoginImpl extends LoginRepo {
  final Service service = Service();
  final String connectCollection = "connect";

  @override
  Future<String> loadDeviceID() async {
    final res = await PlatformDeviceId.getDeviceId;
    if (res == null) {
      throw Exception("Device ID is Empty!");
    }
    return res.split("-").first;
  }

  @override
  Stream<Map<String, dynamic>?> connectStream(String inviteCode) {
    return service.connectRef().doc(inviteCode).snapshots().map((event) {
      final data = event.data();
      if (data == null) {
        return null;
      }
      return data as Map<String, dynamic>;
    });
  }

  @override
  String inviteCode() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(6);
  }

  @override
  Future updateConnection({
    required String inviteCode,
    required Map<String, dynamic> data,
  }) {
    return service.connectRef().doc(inviteCode).set(data);
  }

  @override
  Future disposeInvite(String inviteCode) {
    return service.connectRef().doc(inviteCode).delete();
  }

  @override
  Future requestConnection(String inviteCode) {
    return service.connectRef().doc(inviteCode).get();
  }

  @override
  Future connected(String inviteCode, Map<String, dynamic> data) {
    return service.publicRef(inviteCode).set(data);
  }
}
