import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  DataBase(this.name);
  final String name;
  late Box box;
  Future open() async {
    box = await Hive.openBox(name);
  }

  Future clear() {
    return box.clear();
  }

  dynamic load(String key) {
    return box.get(key);
  }

  Future update(String key, Map<String, dynamic> data) {
    return box.put(key, data);
  }
}
