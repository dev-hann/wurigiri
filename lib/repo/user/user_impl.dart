part of user_repo;

class UserImpl extends UserRepo {
  @override
  Future<String> loadUserID() async {
    final res = await PlatformDeviceId.getDeviceId;
    if (res == null) {
      throw Exception("Device ID is Empty!");
    }
    return res;
  }
}
