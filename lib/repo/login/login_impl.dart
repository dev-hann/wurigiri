part of login_repo;

class LoginImpl extends LoginRepo {
  final FireService service = FireService();
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
    final snapshot = service.stream(
      collection: connectCollection,
      document: inviteCode,
    );
    return snapshot.map((event) {
      final data = event.data();
      if (data == null) {
        return {};
      }
      return data as Map<String, dynamic>;
    });
  }

  @override
  String inviteCode() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(6);
  }

  @override
  Future invite({
    required String inviteCode,
    required Map<String, dynamic> data,
  }) async {
    service.update(
      collection: connectCollection,
      document: inviteCode,
      data: data,
    );
  }

  @override
  Future cancelInvite(String inviteCode) {
    return service.remove(
      collection: connectCollection,
      document: inviteCode,
    );
  }
}
