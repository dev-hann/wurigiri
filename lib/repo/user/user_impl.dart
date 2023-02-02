part of user_repo;

class UserImpl extends UserRepo {
  final FireService service = FireService();
  final String userKey = "user";

  @override
  Future<List<Map<String, dynamic>>> requestUserList() async {
    return await service.getDocumentList(userKey);
  }

  @override
  dynamic loadUser() {
    return null;
  }

  @override
  Future requestUser(String deviceID) {
    return service.getDocument(
      collection: userKey,
      document: deviceID,
    );
  }

  @override
  Future updateUser({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return service.update(
      collection: userKey,
      document: id,
      data: data,
    );
  }
}
