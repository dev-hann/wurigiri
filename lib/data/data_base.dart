import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  DataBase(this.name);
  final String name;
  late Box box;
  Future open() async {
    box = await Hive.openBox(name);
  }

  String lastIndex() {
    if (box.isEmpty) {
      return "0";
    }
    return box.keys.last.toString();
  }

  Future clear() {
    return box.clear();
  }

  dynamic get(String key) {
    return box.get(key);
  }

  List<Map<String, dynamic>> getAll({
    int? page,
    int stride = 30,
  }) {
    final list = box.values.map((e) => Map<String, dynamic>.from(e)).toList();
    if (page == null) {
      return list;
    }
    final length = list.length;
    final begin = (page - 1) * stride;
    if (begin > length) {
      return [];
    }
    final end = min(length, page * stride);
    return list.reversed
        .toList()
        .sublist(
          begin,
          end,
        )
        .reversed
        .toList();
  }

  Future update(String key, Map<String, dynamic> data) {
    return box.put(key, data);
  }

  Stream<Map<String, dynamic>> stream() {
    return box.watch().map((event) {
      final value = event.value;
      if (value == null) return {};
      return Map<String, dynamic>.from(value);
    });
  }
}
