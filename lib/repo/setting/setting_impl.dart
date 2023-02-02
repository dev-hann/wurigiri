part of setting_repo;

class SettingImpl extends SettingRepo {
  final FireService service = FireService();

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
