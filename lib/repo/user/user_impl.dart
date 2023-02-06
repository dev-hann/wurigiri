part of user_repo;

class UserImpl extends UserRepo {
  final Service service = Service();
  final String userCollection = "user";

  @override
  Future init() async {}

  @override
  Future updateUser({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await service.userRef().doc(id).set(data);
  }

  @override
  Future requestUser(String deviceID) async {
    final snapshot = await service.userRef().doc(deviceID).get();
    return snapshot.data() as Map<String, dynamic>;
  }
}
