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
  Stream<Map<String, dynamic>> connectStream(String inviteCode) {
    return service.stream(
      collection: connectCollection,
      document: inviteCode,
    );
  }

  @override
  String inviteCode() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(6);
  }

  @override
  Future updateConnection({
    required String inviteCode,
    required Map<String, dynamic> data,
  }) async {
    service.set(
      collection: connectCollection,
      document: inviteCode,
      data: data,
    );
  }

  @override
  Future disposeInvite(String inviteCode) {
    return service.remove(
      collection: connectCollection,
      document: inviteCode,
    );
  }

  @override
  Future requestConnection(String inviteCode) {
    return service.getDocument(
      collection: connectCollection,
      document: inviteCode,
    );
  }

  @override
  Future connected(String inviteCode, Map<String, dynamic> data) {
    return service.publicRef(inviteCode).set(data);
  }
}
