library setting_repo;

import 'package:cloud_firestore/cloud_firestore.dart';

part 'public_impl.dart';

abstract class PublicRepo {
  Stream<Map<String, dynamic>> get publicStream;
  Future<dynamic> updatePublic(Map<String, dynamic> data);
}
