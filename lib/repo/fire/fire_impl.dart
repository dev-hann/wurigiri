part of fire_repo;

class FireImpl extends FireRepo {
  final FireService service = FireService();
  @override
  Future requestUser(String deviceID) {
    return service.get(
      collection: "user",
      document: deviceID,
    );
  }

  @override
  Future updateUser({
    required String key,
    required Map<String, dynamic> data,
  }) {
    return service.update(
      collection: "user",
      document: key,
      data: data,
    );
  }

  final settingKey = "setting";

  @override
  Stream<Map<String, dynamic>?> get settingStream =>
      service.stream(collection: settingKey, document: settingKey).map(
        (event) {
          final data = event.data();
          if (data == null) {
            return null;
          }
          return event.data() as Map<String, dynamic>;
        },
      );

  @override
  Future updateSetting(Map<String, dynamic> data) {
    return service.update(
      collection: settingKey,
      document: settingKey,
      data: data,
    );
  }
}
