part of user_repo;

class UserImpl extends UserRepo {
  final FireService service = FireService();
  final String userCollection = "user";

  @override
  Future init() async {}

  @override
  Future requestUser(String deviceID) async {
    try {
      return service.getDocument(
        collection: userCollection,
        document: deviceID,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future updateUser({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await service.set(
      collection: userCollection,
      document: id,
      data: data,
    );
  }
}
